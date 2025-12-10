import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

import 'theme/app_colors.dart';
import 'services/user_db_service.dart';

part 'models/sign_item.dart';
part 'screens/welcome_and_auth.dart';
part 'screens/home_screen.dart';
part 'screens/settings_screen.dart';
part 'screens/live_detection_screen.dart';
part 'screens/practice_screen.dart';
part 'screens/history_screen.dart';
part 'screens/sign_detail_screen.dart';

class ArslApp extends StatefulWidget {
  const ArslApp({super.key});

  @override
  State<ArslApp> createState() => _ArslAppState();
}

enum AppLanguage { arabic, english }

class _ArslAppState extends State<ArslApp> {
  ThemeMode _themeMode = ThemeMode.light;
  double _textScaleFactor = 1.0;
  AppLanguage _language = AppLanguage.arabic;

  ThemeMode get themeMode => _themeMode;
  double get textScaleFactor => _textScaleFactor;
  AppLanguage get language => _language;

  void updateThemeMode(ThemeMode mode) {
    setState(() {
      _themeMode = mode;
    });
  }

  void updateTextScale(double value) {
    setState(() {
      _textScaleFactor = value;
    });
  }

  void updateLanguage(AppLanguage lang) {
    setState(() {
      _language = lang;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ArSL Sign Recognition',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,

// LIGHT THEME
theme: ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: ujBlue,
    brightness: Brightness.light,
  ),
  brightness: Brightness.light,
  scaffoldBackgroundColor: const Color(0xFFF5F5F5),
  appBarTheme: const AppBarTheme(
    backgroundColor: ujBlue,
    foregroundColor: Colors.white, // title & icons
    centerTitle: false,
    elevation: 0,
  ),
),

// DARK THEME
darkTheme: ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: ujBlue,
    brightness: Brightness.dark,
  ),
  brightness: Brightness.dark,
  appBarTheme: const AppBarTheme(
    backgroundColor: ujBlue,
    foregroundColor: Colors.white,
    centerTitle: false,
    elevation: 0,
  ),
),


      // global textScale + RTL/LTR based on language
      builder: (context, child) {
        final mediaQuery = MediaQuery.of(context);
        return MediaQuery(
          data: mediaQuery.copyWith(
            textScaler: TextScaler.linear(_textScaleFactor),
          ),
          child: Directionality(
            textDirection: _language == AppLanguage.arabic
                ? TextDirection.rtl
                : TextDirection.ltr,
            child: child ?? const SizedBox.shrink(),
          ),
        );
      },

      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/auth': (context) => const AuthChoiceScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/home': (context) => const HomeScreen(),
        '/detect': (context) => const LiveDetectionScreen(),
        '/practice': (context) => const PracticeScreen(),
        '/history': (context) => const HistoryScreen(),
        '/settings': (context) => const SettingsScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == SignDetailScreen.routeName) {
          final sign = settings.arguments as SignItem;
          return MaterialPageRoute(
            builder: (_) => SignDetailScreen(sign: sign),
          );
        }
        return null;
      },
    );
  }
}

/// translation helper
String tr(BuildContext context, String ar, String en) {
  final appState = context.findAncestorStateOfType<_ArslAppState>();
  final lang = appState?.language ?? AppLanguage.arabic;
  return lang == AppLanguage.arabic ? ar : en;
}

