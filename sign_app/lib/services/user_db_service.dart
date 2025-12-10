import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class AppUser {
  final int? id;
  final String name;
  final String email;
  final String passwordHash;

  const AppUser({
    this.id,
    required this.name,
    required this.email,
    required this.passwordHash,
  });

  AppUser copyWith({
    int? id,
    String? name,
    String? email,
    String? passwordHash,
  }) {
    return AppUser(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      passwordHash: passwordHash ?? this.passwordHash,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password_hash': passwordHash,
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      id: map['id'] as int?,
      name: map['name'] as String,
      email: map['email'] as String,
      passwordHash: map['password_hash'] as String,
    );
  }
}

class UserAlreadyExistsException implements Exception {
  final String message;
  const UserAlreadyExistsException([this.message = 'User already exists']);
}

class UserDatabaseService {
  UserDatabaseService._();
  static final UserDatabaseService instance = UserDatabaseService._();

  Database? _db;
  AppUser? _currentUser;

  AppUser? get currentUser => _currentUser;

  Future<void> init() async {
    if (_db != null) return;
    // On desktop platforms sqflite requires the ffi factory.
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    }
    _db = await _openDb();
  }

  Future<Database> get _database async {
    if (_db != null) return _db!;
    _db = await _openDb();
    return _db!;
  }

  void setCurrentUser(AppUser? user) {
    _currentUser = user;
  }

  void logout() {
    _currentUser = null;
  }

  Future<Database> _openDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'sign_app.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE users(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            email TEXT NOT NULL UNIQUE,
            password_hash TEXT NOT NULL
          );
        ''');
      },
    );
  }

  Future<AppUser> createUser({
    required String name,
    required String email,
    required String password,
  }) async {
    final db = await _database;

    final existing = await getUserByEmail(email);
    if (existing != null) {
      throw const UserAlreadyExistsException();
    }

    final passwordHash = _hashPassword(password);
    final id = await db.insert('users', {
      'name': name.trim(),
      'email': email.trim().toLowerCase(),
      'password_hash': passwordHash,
    });

    return AppUser(
      id: id,
      name: name.trim(),
      email: email.trim().toLowerCase(),
      passwordHash: passwordHash,
    );
  }

  Future<AppUser?> getUserByEmail(String email) async {
    final db = await _database;
    final normalizedEmail = email.trim().toLowerCase();

    final rows = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [normalizedEmail],
      limit: 1,
    );

    if (rows.isEmpty) return null;
    return AppUser.fromMap(rows.first);
  }

  Future<AppUser?> validateCredentials({
    required String email,
    required String password,
  }) async {
    final user = await getUserByEmail(email);
    if (user == null) return null;

    final incomingHash = _hashPassword(password);
    if (incomingHash != user.passwordHash) return null;
    return user;
  }

  Future<void> close() async {
    await _db?.close();
    _db = null;
  }

  String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    return sha256.convert(bytes).toString();
  }
}
