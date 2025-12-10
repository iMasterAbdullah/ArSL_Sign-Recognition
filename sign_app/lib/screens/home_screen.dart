part of '../app.dart';

// 2) HOME DASHBOARD SCREEN
//

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _showProfile() {
    final user = UserDatabaseService.instance.currentUser;
    final isLoggedIn = user != null;

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 22,
                    child: Icon(Icons.person),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user?.name ?? tr(context, 'ضيف', 'Guest'),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        user?.email ??
                            tr(context, 'لم يتم حفظ بريد إلكتروني', 'No email saved'),
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              if (!isLoggedIn) ...[
                Text(
                  tr(
                    context,
                    'انشئ حساباً او قم بتسجيل الدخول لحفظ تقدمك',
                    'Sign up or log in to save your progress.',
                  ),
                  style: const TextStyle(fontSize: 13),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, '/login');
                        },
                        icon: const Icon(Icons.login),
                        label: Text(tr(context, 'تسجيل الدخول', 'Login')),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, '/signup');
                        },
                        icon: const Icon(Icons.person_add),
                        label: Text(tr(context, 'إنشاء حساب', 'Sign up')),
                      ),
                    ),
                  ],
                ),
              ] else ...[
                Text(
                  tr(
                    context,
                    'تم تسجيل دخولك',
                    'You are signed in',
                  ),
                  style: const TextStyle(fontSize: 13),
                ),
                const SizedBox(height: 12),
                FilledButton.icon(
                  onPressed: () {
                    UserDatabaseService.instance.logout();
                    Navigator.pop(context);
                    setState(() {});
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          tr(context, 'تم تسجيل خروجك', 'Logged out'),
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.logout),
                  label: Text(tr(context, 'تسجيل الخروج', 'Logout')),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // build the tile config here, but translation happens per build
    final tiles = [
      _HomeTileData(
        icon: Icons.camera_alt_rounded,
        color: Colors.teal,
        route: '/detect',
        titleAr: 'التعرف الحي',
        titleEn: 'Live detection',
        subtitleAr: 'استخدم الكاميرا للتعرف على الإشارة',
        subtitleEn: 'Use the camera to recognize signs',
      ),
      _HomeTileData(
        icon: Icons.school_rounded,
        color: Colors.deepPurple,
        route: '/practice',
        titleAr: 'تعلم الإشارات',
        titleEn: 'Practice signs',
        subtitleAr: 'تعلّم الحروف والكلمات بلغة الإشارة العربية',
        subtitleEn: 'Learn letters and words in Arabic Sign Language',
      ),
      _HomeTileData(
        icon: Icons.history_rounded,
        color: Colors.indigo,
        route: '/history',
        titleAr: 'السجل',
        titleEn: 'History',
        subtitleAr: 'عرض الإشارات التي تم التعرف عليها',
        subtitleEn: 'View previously recognized signs',
      ),
      _HomeTileData(
        icon: Icons.settings_rounded,
        color: Colors.orange,
        route: '/settings',
        titleAr: 'الإعدادات',
        titleEn: 'Settings',
        subtitleAr: 'اللغة، الوضع الداكن، والمزيد',
        subtitleEn: 'Language, dark mode, and more',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('ArSL Sign Recognition'),
        centerTitle: false,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: _showProfile,
            icon: const Icon(Icons.person),
            tooltip: tr(context, 'الملف الشخصي', 'Profile'),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tr(context, 'مرحباً 👋', 'Hi 👋'),
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      tr(
                        context,
                        'اختر ما تريد القيام به اليوم',
                        'Choose what you want to do today',
                      ),
                      style: const TextStyle(fontSize: 15),
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
                itemBuilder: (context, index) {
                  final tile = tiles[index];

                  final title =
                      tr(context, tile.titleAr, tile.titleEn); // translated
                  final subtitle = tr(
                    context,
                    tile.subtitleAr,
                    tile.subtitleEn,
                  );

                  return _HomeTile(
                    title: title,
                    subtitle: subtitle,
                    icon: tile.icon,
                    color: tile.color,
                    onTap: tile.route == null
                        ? null
                        : () async {
                            if (tile.route == '/settings') {
                              await Navigator.pushNamed(context, tile.route!);
                              setState(() {}); // forces rebuild with new lang
                            } else {
                              Navigator.pushNamed(context, tile.route!);
                            }
                          },
                  );
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
  final String titleAr;
  final String titleEn;
  final String subtitleAr;
  final String subtitleEn;
  final IconData icon;
  final Color color;
  final String? route;

  _HomeTileData({
    required this.titleAr,
    required this.titleEn,
    required this.subtitleAr,
    required this.subtitleEn,
    required this.icon,
    required this.color,
    this.route,
  });
}

class _HomeTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;

  const _HomeTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: theme.colorScheme.surface,
          boxShadow: isDark
              ? []
              : [
                  BoxShadow(
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                    color: Colors.black.withValues(alpha: 0.08),
                  ),
                ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 22,
              backgroundColor: color.withValues(alpha: 0.1),
              child: Icon(icon, color: color, size: 24),
            ),
            const Spacer(),
            Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


//



