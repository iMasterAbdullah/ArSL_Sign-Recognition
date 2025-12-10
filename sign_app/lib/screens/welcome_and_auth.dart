part of '../app.dart';

// 1) WELCOME / ONBOARDING SCREEN
//

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  void _toggleLanguage() {
    final appState = context.findAncestorStateOfType<_ArslAppState>();
    final currentLang = appState?.language ?? AppLanguage.arabic;
    final newLang = currentLang == AppLanguage.arabic
        ? AppLanguage.english
        : AppLanguage.arabic;

    // 1) Update global language (for all screens)
    appState?.updateLanguage(newLang);

    // 2) Force WelcomeScreen itself to rebuild NOW
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const ujBlue = Color(0xFF005CA9); // University of Jeddah blue

    final appState = context.findAncestorStateOfType<_ArslAppState>();
    final lang = appState?.language ?? AppLanguage.arabic;
    final isArabic = lang == AppLanguage.arabic;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton.icon(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    onPressed: _toggleLanguage,
                    icon: const Icon(Icons.language, size: 18),
                    label: Text(
                      isArabic ? 'English' : 'العربية',
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),
              Expanded(
                child: Center(
                  child: Container(
                    width: size.width * 0.7,
                    height: size.width * 0.7,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      color: ujBlue.withValues(alpha: 0.08),
                    ),
                    child: const Icon(
                      Icons.front_hand,
                      size: 120,
                      color: ujBlue,
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
              Text(
                tr(
                  context,
                  'تعلم وتعرّف على لغة الإشارة العربية\nوقم بالتعرف على الإشارات باستخدام الكاميرا.',
                  'Learn and explore Arabic Sign Language\nand recognize signs using the camera.',
                ),
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 15),
              ),

              const SizedBox(height: 24),
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
                    backgroundColor: ujBlue,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, '/auth'),
                  icon: const Icon(Icons.arrow_forward_rounded),
                  label: Text(
                    tr(context, 'متابعة', 'Continue'),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),
              TextButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(24)),
                    ),
                    builder: (_) => const _AboutBottomSheet(),
                  );
                },
                child: Text(tr(context, 'عن التطبيق', 'About the app')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}




class _LanguageToggleButton extends StatelessWidget {
  const _LanguageToggleButton();

  @override
  Widget build(BuildContext context) {
    final appState = context.findAncestorStateOfType<_ArslAppState>();
    final lang = appState?.language ?? AppLanguage.arabic;
    final isArabic = lang == AppLanguage.arabic;

    return TextButton.icon(
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      onPressed: () {
        appState?.updateLanguage(
          isArabic ? AppLanguage.english : AppLanguage.arabic,
        );
      },
      icon: Icon(Icons.language, size: 18),
      label: Text(
        isArabic ? 'English' : 'العربية',
        style: TextStyle(fontSize: 13),
      ),
    );
  }
}



class _AboutBottomSheet extends StatelessWidget {
  const _AboutBottomSheet();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tr(context, 'عن التطبيق', 'About the app'),
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          Text(
            tr(
              context,
              'هذا التطبيق يساعدك على التعرف على لغة الإشارة العربية (ArSL) '
              'من خلال التعرف على الإشارات بواسطة الكاميرا، إضافة إلى وضع التدريب '
              'والتذكّر لسجل الإشارات.',
              'This app helps you learn Arabic Sign Language (ArSL) '
              'by recognizing signs through the camera, with practice mode '
              'and a history of recognized signs.',
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}


//
// 1.1 AUTH CHOICE SCREEN
//

class AuthChoiceScreen extends StatelessWidget {
  const AuthChoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr(context, 'مرحباً بك', 'Welcome')),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),
            Text(
              tr(
                context,
                'سجّل دخولك لزيادة تجربتك، أو تابع كضيف.',
                'Sign in to get the full experience, or continue as a guest.',
              ),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 15),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                icon: const Icon(Icons.login),
                label: Text(
                  tr(context, 'تسجيل الدخول', 'Login'),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, '/signup');
                },
                icon: const Icon(Icons.person_add),
                label: Text(
                  tr(context, 'إنشاء حساب جديد', 'Create new account'),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 16),
            TextButton.icon(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/home');
              },
              icon: const Icon(Icons.person_outline),
              label: Text(tr(context, 'المتابعة كضيف', 'Continue as guest')),
            ),
            const Spacer(),
            Text(
              tr(
                context,
                'بالتسجيل يمكنك حفظ تاريخ الإشارات والتقدم في التدريب.',
                'By creating an account, you can save your sign history and learning progress.',
              ),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

//
// 1.2 LOGIN SCREEN
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
  bool _isLoading = false;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final user = await UserDatabaseService.instance.validateCredentials(
        email: _emailCtrl.text,
        password: _passwordCtrl.text,
      );

      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              tr(
                context,
                'البريد الإلكتروني او كلمة المرور غير صالحة',
                'Invalid email or password.',
              ),
            ),
          ),
        );
        return;
      }

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            tr(
              context,
              'مسجل دخول كـ ${user.name}',
              'Logged in as ${user.name}',
            ),
          ),
        ),
      );
      UserDatabaseService.instance.setCurrentUser(user);
      Navigator.pushReplacementNamed(context, '/home');
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            tr(
              context,
              'حدث خطأ ما، يرجى إعادة المحاولة',
              'Something went wrong. Please try again.',
            ),
          ),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr(context, 'تسجيل الدخول', 'Login')),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),
              Text(
                tr(context, 'مرحباً بعودتك 👋', 'Welcome back 👋'),
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                tr(
                  context,
                  'قم بتسجيل الدخول لمزامنة سجل الإشارات والتقدم في التدريب.',
                  'Sign in to sync your sign history and training progress.',
                ),
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 13),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _emailCtrl,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: tr(
                    context,
                    'البريد الإلكتروني',
                    'Email',
                  ),
                  prefixIcon: const Icon(Icons.email),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return tr(
                      context,
                      'الرجاء إدخال البريد الإلكتروني',
                      'Please enter your email',
                    );
                  }
                  if (!value.contains('@')) {
                    return tr(
                      context,
                      'بريد إلكتروني غير صالح',
                      'Invalid email address',
                    );
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _passwordCtrl,
                obscureText: _obscure,
                decoration: InputDecoration(
                  labelText: tr(context, 'كلمة المرور', 'Password'),
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
                    return tr(
                      context,
                      'الرجاء إدخال كلمة المرور',
                      'Please enter your password',
                    );
                  }
                  if (value.length < 6) {
                    return tr(
                      context,
                      'كلمة المرور يجب أن تكون على الأقل 6 أحرف',
                      'Password must be at least 6 characters',
                    );
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _isLoading ? null : _submit,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: _isLoading
                        ? const SizedBox(
                            height: 18,
                            width: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : Text(tr(context, 'تسجيل الدخول', 'Login')),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/signup');
                },
                child: Text(
                  tr(
                    context,
                    'ليس لديك حساب؟ إنشاء حساب جديد',
                    "Don't have an account? Sign up",
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/home');
                  },
                  child: Text(
                    tr(
                      context,
                      'المتابعة كضيف بدلاً من ذلك',
                      'Continue as guest instead',
                    ),
                  ),
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
// 1.3 SIGNUP SCREEN
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
  bool _isLoading = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final newUser = await UserDatabaseService.instance.createUser(
        name: _nameCtrl.text,
        email: _emailCtrl.text,
        password: _passwordCtrl.text,
      );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            tr(
              context,
              'تم إنشاء الحساب لـ ${newUser.name}',
              'Account created for ${newUser.name}',
            ),
          ),
        ),
      );
      UserDatabaseService.instance.setCurrentUser(newUser);
      Navigator.pushReplacementNamed(context, '/home');
    } on UserAlreadyExistsException {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            tr(
              context,
              'تم تسجيل البريد الإلكتروني مسبقاً',
              'Email is already registered.',
            ),
          ),
        ),
      );
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            tr(
              context,
              'حدث خطأ ما، الرجاء إعادة المحاولة',
              'Something went wrong. Please try again.',
            ),
          ),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr(context, 'إنشاء حساب', 'Sign up')),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),
              Text(
                tr(
                  context,
                  'ابدأ رحلتك مع لغة الإشارة ✋',
                  'Start your journey with sign language ✋',
                ),
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                tr(
                  context,
                  'أنشئ حساباً لحفظ تقدمك وسجل الإشارات.',
                  'Create an account to save your progress and sign history.',
                ),
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 13),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _nameCtrl,
                decoration: InputDecoration(
                  labelText: tr(context, 'الاسم الكامل', 'Full name'),
                  prefixIcon: const Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return tr(
                      context,
                      'الرجاء إدخال الاسم',
                      'Please enter your name',
                    );
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _emailCtrl,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: tr(context, 'البريد الإلكتروني', 'Email'),
                  prefixIcon: const Icon(Icons.email),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return tr(
                      context,
                      'الرجاء إدخال البريد الإلكتروني',
                      'Please enter your email',
                    );
                  }
                  if (!value.contains('@')) {
                    return tr(
                      context,
                      'بريد إلكتروني غير صالح',
                      'Invalid email address',
                    );
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _passwordCtrl,
                obscureText: _obscure,
                decoration: InputDecoration(
                  labelText: tr(context, 'كلمة المرور', 'Password'),
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
                    return tr(
                      context,
                      'الرجاء إدخال كلمة المرور',
                      'Please enter a password',
                    );
                  }
                  if (value.length < 6) {
                    return tr(
                      context,
                      'كلمة المرور يجب أن تكون على الأقل 6 أحرف',
                      'Password must be at least 6 characters',
                    );
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _confirmCtrl,
                obscureText: _obscureConfirm,
                decoration: InputDecoration(
                  labelText:
                      tr(context, 'تأكيد كلمة المرور', 'Confirm password'),
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
                    return tr(
                      context,
                      'الرجاء تأكيد كلمة المرور',
                      'Please confirm your password',
                    );
                  }
                  if (value != _passwordCtrl.text) {
                    return tr(
                      context,
                      'كلمتا المرور غير متطابقتين',
                      'Passwords do not match',
                    );
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _isLoading ? null : _submit,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: _isLoading
                        ? const SizedBox(
                            height: 18,
                            width: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : Text(tr(context, 'إنشاء حساب', 'Sign up')),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/login');
                },
                child: Text(
                  tr(
                    context,
                    'لديك حساب بالفعل؟ تسجيل الدخول',
                    'Already have an account? Login',
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/home');
                  },
                  child: Text(
                    tr(
                      context,
                      'المتابعة كضيف',
                      'Continue as guest',
                    ),
                  ),
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







