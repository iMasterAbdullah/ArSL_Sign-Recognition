import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); 
  runApp(const ArslApp());
}

class ArslApp extends StatelessWidget {
  const ArslApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ArSL Sign Recognition',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
      ),
      // NEW: Start from Welcome, then go to Auth screen
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/auth': (context) => const AuthChoiceScreen(),   // NEW
        '/login': (context) => const LoginScreen(),       // NEW
        '/signup': (context) => const SignupScreen(),     // NEW
        '/home': (context) => const HomeScreen(),
        '/detect': (context) => const LiveDetectionScreen(),
        '/practice': (context) => const PracticeScreen(),
        '/history': (context) => const HistoryScreen(),
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

//
// MODELS (dummy)
//

class SignItem {
  final String label;     // e.g. "أ"
  final String name;      // e.g. "Letter Alef"
  final String category;  // e.g. "Letter" / "Word"
  final String description;

  const SignItem({
    required this.label,
    required this.name,
    required this.category,
    required this.description,
  });
}

final List<SignItem> mockSigns = [
  const SignItem(
    label: 'أ',
    name: 'Letter Alef',
    category: 'Letter',
    description:
        'Basic Arabic sign for the letter Alef. Focus on clear hand shape and position in front of the body.',
  ),
  const SignItem(
    label: 'ب',
    name: 'Letter Baa',
    category: 'Letter',
    description:
        'Sign for the letter Baa. Keep the hand steady and maintain eye contact for better communication.',
  ),
  const SignItem(
    label: 'سلام',
    name: 'Salam',
    category: 'Word',
    description:
        'Common greeting meaning "peace". Used frequently in daily conversations.',
  ),
];

//
// 1) WELCOME / ONBOARDING SCREEN
//

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 16),
              // Illustration / Logo placeholder
              Expanded(
                child: Center(
                  child: Container(
                    width: size.width * 0.7,
                    height: size.width * 0.7,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      color: Colors.teal.withOpacity(0.1),
                    ),
                    child: const Icon(
                      Icons.front_hand,
                      size: 120,
                      color: Colors.teal,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'ArSL Sign Recognition',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'تعلم وتعرّف على لغة الإشارة العربية\nوقم بالتعرف على الإشارات باستخدام الكاميرا.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15),
              ),
              const SizedBox(height: 24),
              // CHANGED: Go to AuthChoiceScreen instead of Home
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, '/auth'),
                  icon: const Icon(Icons.arrow_forward_rounded),
                  label: const Text(
                    'متابعة',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () {
                  // Show simple bottom sheet with info
                  showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(24)),
                    ),
                    builder: (_) => const _AboutBottomSheet(),
                  );
                },
                child: const Text('عن التطبيق'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AboutBottomSheet extends StatelessWidget {
  const _AboutBottomSheet();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'عن التطبيق',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          Text(
            'هذا التطبيق يساعدك على التعرف على لغة الإشارة العربية (ArSL) '
            'من خلال التعرف على الإشارات بواسطة الكاميرا، إضافة إلى وضع التدريب '
            'والتذكّر لسجل الإشارات.',
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}

//
// 1.1 AUTH CHOICE SCREEN (NEW)
//

class AuthChoiceScreen extends StatelessWidget {
  const AuthChoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('مرحباً بك'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),
            const Text(
              'سجّل دخولك لزيادة تجربتك، أو تابع كضيف.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15),
            ),
            const SizedBox(height: 32),
            // Login button
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                icon: const Icon(Icons.login),
                label: const Text(
                  'تسجيل الدخول',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const SizedBox(height: 12),
            // Signup button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, '/signup');
                },
                icon: const Icon(Icons.person_add),
                label: const Text(
                  'إنشاء حساب جديد',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 16),
            // Continue as guest
            TextButton.icon(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/home');
              },
              icon: const Icon(Icons.person_outline),
              label: const Text('المتابعة كضيف'),
            ),
            const Spacer(),
            const Text(
              'بالتسجيل يمكنك حفظ تاريخ الإشارات والتقدم في التدريب.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

//
// 1.2 LOGIN SCREEN (NEW)
//

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _obscure = true;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      // TODO: integrate with real auth backend
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم تسجيل الدخول (وهمياً).')),
      );
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تسجيل الدخول'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),
              const Text(
                'مرحباً بعودتك 👋',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                'قم بتسجيل الدخول لمزامنة سجل الإشارات والتقدم في التدريب.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _emailCtrl,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'البريد الإلكتروني',
                  prefixIcon: Icon(Icons.email),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء إدخال البريد الإلكتروني';
                  }
                  if (!value.contains('@')) {
                    return 'بريد إلكتروني غير صالح';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _passwordCtrl,
                obscureText: _obscure,
                decoration: InputDecoration(
                  labelText: 'كلمة المرور',
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _obscure = !_obscure;
                      });
                    },
                    icon: Icon(_obscure
                        ? Icons.visibility_off
                        : Icons.visibility),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء إدخال كلمة المرور';
                  }
                  if (value.length < 6) {
                    return 'كلمة المرور يجب أن تكون على الأقل 6 أحرف';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _submit,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Text('تسجيل الدخول'),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/signup');
                },
                child: const Text('ليس لديك حساب؟ إنشاء حساب جديد'),
              ),
              const SizedBox(height: 16),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/home');
                  },
                  child: const Text('المتابعة كضيف بدلاً من ذلك'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//
// 1.3 SIGNUP SCREEN (NEW)
//

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  bool _obscure = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      // TODO: integrate with real signup backend
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم إنشاء الحساب (وهمياً).')),
      );
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إنشاء حساب'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),
              const Text(
                'ابدأ رحلتك مع لغة الإشارة ✋',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                'أنشئ حساباً لحفظ تقدمك وسجل الإشارات.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _nameCtrl,
                decoration: const InputDecoration(
                  labelText: 'الاسم الكامل',
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء إدخال الاسم';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _emailCtrl,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'البريد الإلكتروني',
                  prefixIcon: Icon(Icons.email),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء إدخال البريد الإلكتروني';
                  }
                  if (!value.contains('@')) {
                    return 'بريد إلكتروني غير صالح';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _passwordCtrl,
                obscureText: _obscure,
                decoration: InputDecoration(
                  labelText: 'كلمة المرور',
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _obscure = !_obscure;
                      });
                    },
                    icon: Icon(
                      _obscure ? Icons.visibility_off : Icons.visibility,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء إدخال كلمة المرور';
                  }
                  if (value.length < 6) {
                    return 'كلمة المرور يجب أن تكون على الأقل 6 أحرف';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _confirmCtrl,
                obscureText: _obscureConfirm,
                decoration: InputDecoration(
                  labelText: 'تأكيد كلمة المرور',
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _obscureConfirm = !_obscureConfirm;
                      });
                    },
                    icon: Icon(
                      _obscureConfirm
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء تأكيد كلمة المرور';
                  }
                  if (value != _passwordCtrl.text) {
                    return 'كلمتا المرور غير متطابقتين';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _submit,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Text('إنشاء حساب'),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/login');
                },
                child: const Text('لديك حساب بالفعل؟ تسجيل الدخول'),
              ),
              const SizedBox(height: 16),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/home');
                  },
                  child: const Text('المتابعة كضيف'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//
// 2) HOME DASHBOARD SCREEN
//

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tiles = [
      _HomeTileData(
        title: 'التعرف الحي',
        subtitle: 'استخدم الكاميرا للتعرف على الإشارة',
        icon: Icons.camera_alt_rounded,
        color: Colors.teal,
        route: '/detect',
      ),
      _HomeTileData(
        title: 'تدريب الإشارات',
        subtitle: 'تعلّم الحروف والكلمات بلغة الإشارة',
        icon: Icons.school_rounded,
        color: Colors.deepPurple,
        route: '/practice',
      ),
      _HomeTileData(
        title: 'السجل',
        subtitle: 'عرض الإشارات التي تم التعرف عليها',
        icon: Icons.history_rounded,
        color: Colors.indigo,
        route: '/history',
      ),
      _HomeTileData(
        title: 'الإعدادات',
        subtitle: 'اللغة، الوضع الداكن، والمزيد',
        icon: Icons.settings_rounded,
        color: Colors.orange,
        route: null, // not implemented yet
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('ArSL Sign Recognition'),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.person),
            tooltip: 'Profile',
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Greeting / Header
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'مرحباً 👋',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'اختر ما تريد القيام به اليوم',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Tiles
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: tiles.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 170,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemBuilder: (_, index) {
                  final tile = tiles[index];
                  return _HomeTile(tile: tile);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HomeTileData {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final String? route;

  _HomeTileData({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    this.route,
  });
}

class _HomeTile extends StatelessWidget {
  final _HomeTileData tile;

  const _HomeTile({required this.tile});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: tile.route == null
          ? null
          : () {
              Navigator.pushNamed(context, tile.route!);
            },
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 8,
              offset: const Offset(0, 4),
              color: Colors.black.withOpacity(0.08),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 22,
              backgroundColor: tile.color.withOpacity(0.1),
              child: Icon(tile.icon, color: tile.color, size: 24),
            ),
            const Spacer(),
            Text(
              tile.title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              tile.subtitle,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

//
// 3) LIVE DETECTION SCREEN (camera UI placeholder)
//

class LiveDetectionScreen extends StatefulWidget {
  const LiveDetectionScreen({super.key});

  @override
  State<LiveDetectionScreen> createState() => _LiveDetectionScreenState();
}

class _LiveDetectionScreenState extends State<LiveDetectionScreen> {
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;

  bool isDetecting = false;
  String? currentSignLabel; // E.g. 'أ'
  String? currentSignName;  // E.g. 'Letter Alef'
  double? confidence;       // 0.0 - 1.0

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    try {
      final cameras = await availableCameras();

      // Prefer back camera
      final backCamera = cameras.firstWhere(
        (c) => c.lensDirection == CameraLensDirection.back,
        orElse: () => cameras.first,
      );

      _controller = CameraController(
        backCamera,
        ResolutionPreset.medium,
        enableAudio: false,
      );

      _initializeControllerFuture = _controller!.initialize();
      setState(() {});
    } catch (e) {
      debugPrint('Error initializing camera: $e');
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _toggleDetection() {
    setState(() {
      isDetecting = !isDetecting;
      if (!isDetecting) {
        currentSignLabel = null;
        currentSignName = null;
        confidence = null;
      } else {
        // TODO: here you’ll connect your ML model and update these values
        currentSignLabel = 'أ';
        currentSignName = 'Letter Alef';
        confidence = 0.92;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final resultCard = Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: currentSignLabel == null
            ? const Text(
                'لا توجد نتيجة بعد.\nضع يدك أمام الكاميرا لبدء التعرف على الإشارة.',
              )
            : Row(
                children: [
                  CircleAvatar(
                    radius: 26,
                    backgroundColor: Colors.teal.withOpacity(0.12),
                    child: Text(
                      currentSignLabel!,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          currentSignName ?? '',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (confidence != null) ...[
                          const SizedBox(height: 4),
                          Text(
                            'الدقة التقريبية: ${(confidence! * 100).toStringAsFixed(1)}٪',
                            style: const TextStyle(fontSize: 13),
                          ),
                          const SizedBox(height: 8),
                          LinearProgressIndicator(
                            value: confidence!.clamp(0, 1),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('التعرف الحي على الإشارة'),
      ),
      body: Column(
        children: [
          // CAMERA AREA
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: _controller == null
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : FutureBuilder(
                        future: _initializeControllerFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return Stack(
                              fit: StackFit.expand,
                              children: [
                                CameraPreview(_controller!),
                                Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: CustomPaint(
                                    painter: _CornersPainter(),
                                  ),
                                ),
                              ],
                            );
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text(
                                'حدث خطأ في تشغيل الكاميرا:\n${snapshot.error}',
                                textAlign: TextAlign.center,
                              ),
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
              ),
            ),
          ),

          // RESULT + INFO
          resultCard,
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: const [
                Icon(Icons.info_outline, size: 18),
                SizedBox(width: 6),
                Expanded(
                  child: Text(
                    'تأكد من وجود إضاءة جيدة، وأن اليد ظاهرة بوضوح داخل إطار الكاميرا.',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // START / STOP BUTTON
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: _controller == null ? null : _toggleDetection,
                icon: Icon(
                  isDetecting
                      ? Icons.stop_circle_outlined
                      : Icons.play_arrow_rounded,
                ),
                label: Text(
                  isDetecting ? 'إيقاف التعرف' : 'بدء التعرف',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class _CornersPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.tealAccent
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    const cornerLength = 24.0;

    // top-left
    canvas.drawLine(
      const Offset(0, 0),
      const Offset(cornerLength, 0),
      paint,
    );
    canvas.drawLine(
      const Offset(0, 0),
      const Offset(0, cornerLength),
      paint,
    );

    // top-right
    canvas.drawLine(
      Offset(size.width, 0),
      Offset(size.width - cornerLength, 0),
      paint,
    );
    canvas.drawLine(
      Offset(size.width, 0),
      Offset(size.width, cornerLength),
      paint,
    );

    // bottom-left
    canvas.drawLine(
      Offset(0, size.height),
      Offset(0, size.height - cornerLength),
      paint,
    );
    canvas.drawLine(
      Offset(0, size.height),
      Offset(cornerLength, size.height),
      paint,
    );

    // bottom-right
    canvas.drawLine(
      Offset(size.width, size.height),
      Offset(size.width - cornerLength, size.height),
      paint,
    );
    canvas.drawLine(
      Offset(size.width, size.height),
      Offset(size.width, size.height - cornerLength),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

//
// 4) PRACTICE SIGNS SCREEN
//

class PracticeScreen extends StatelessWidget {
  const PracticeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تدريب الإشارات'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: mockSigns.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final sign = mockSigns[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              leading: CircleAvatar(
                radius: 22,
                backgroundColor: Colors.teal.withOpacity(0.1),
                child: Text(
                  sign.label,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              title: Text(sign.name),
              subtitle: Text(sign.category),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  SignDetailScreen.routeName,
                  arguments: sign,
                );
              },
            ),
          );
        },
      ),
    );
  }
}

//
// 5) HISTORY SCREEN (dummy data)
//

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final history = [
      {'time': 'اليوم - 10:30 ص', 'sign': mockSigns[0]},
      {'time': 'اليوم - 10:25 ص', 'sign': mockSigns[1]},
      {'time': 'أمس - 5:15 م', 'sign': mockSigns[2]},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('سجل الإشارات'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: history.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final item = history[index];
          final sign = item['sign'] as SignItem;
          final time = item['time'] as String;

          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              leading: CircleAvatar(
                radius: 22,
                backgroundColor: Colors.indigo.withOpacity(0.1),
                child: Text(
                  sign.label,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              title: Text(sign.name),
              subtitle: Text(time),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  SignDetailScreen.routeName,
                  arguments: sign,
                );
              },
            ),
          );
        },
      ),
    );
  }
}

//
// 6) SIGN DETAIL SCREEN
//

class SignDetailScreen extends StatelessWidget {
  static const routeName = '/sign-detail';

  final SignItem sign;

  const SignDetailScreen({super.key, required this.sign});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(sign.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: size.width,
              height: size.width * 0.6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: Colors.grey.shade200,
              ),
              child: const Center(
                child: Icon(
                  Icons.image_outlined,
                  size: 56,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: Colors.teal.withOpacity(0.1),
                  child: Text(
                    sign.label,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      sign.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      sign.category,
                      style: const TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              sign.description,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            const Text(
              'نصائح للتطبيق:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              '• تأكد من أن اليد واضحة ضمن الكاميرا.\n'
              '• كرر الإشارة أكثر من مرة لتثبيت الحركة.\n'
              '• حاول تقليد السرعة الصحيحة ولغة الجسد.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: () {
                // In future: navigate to camera with this sign as "target"
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'سيتم ربط هذا الزر بوضع التدريب بالكاميرا لاحقاً.',
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.front_hand),
              label: const Text('جرّب هذه الإشارة الآن'),
            ),
          ],
        ),
      ),
    );
  }
}
