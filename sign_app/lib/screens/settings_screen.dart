part of '../app.dart';
// ignore_for_file: deprecated_member_use

// 3) SETTINGS SCREEN
//

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _showTips = true;
  bool _enableHaptics = true;

  @override
  Widget build(BuildContext context) {
    final appState = context.findAncestorStateOfType<_ArslAppState>();

    final isDark = appState?.themeMode == ThemeMode.dark;
    final fontScale = appState?.textScaleFactor ?? 1.0;
    final lang = appState?.language ?? AppLanguage.arabic;

    return Scaffold(
      appBar: AppBar(
        title: Text(tr(context, 'الإعدادات', 'Settings')),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Language section
          Text(
            tr(context, 'اللغة', 'Language'),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          RadioListTile<AppLanguage>(
            title: const Text('العربية'),
            value: AppLanguage.arabic,
            groupValue: lang,
            onChanged: (value) {
              if (value != null) {
                appState?.updateLanguage(value);
                setState(() {});
              }
            },
          ),
          RadioListTile<AppLanguage>(
            title: const Text('English'),
            value: AppLanguage.english,
            groupValue: lang,
            onChanged: (value) {
              if (value != null) {
                appState?.updateLanguage(value);
                setState(() {});
              }
            },
          ),
          const SizedBox(height: 24),

          // Appearance
          Text(
            tr(context, 'المظهر', 'Appearance'),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          SwitchListTile(
            title: Text(tr(context, 'الوضع الداكن', 'Dark mode')),
            subtitle: Text(
              tr(context, 'تفعيل الوضع الداكن للتطبيق',
                  'Enable dark theme for the app'),
            ),
            value: isDark,
            onChanged: (value) {
              appState?.updateThemeMode(
                value ? ThemeMode.dark : ThemeMode.light,
              );
              setState(() {});
            },
          ),

          const SizedBox(height: 16),
          Text(
            tr(context, 'حجم الخط', 'Font size'),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Slider(
                value: fontScale,
                min: 0.8,
                max: 1.4,
                divisions: 6,
                label: '${(fontScale * 100).round()}٪',
                onChanged: (value) {
                  appState?.updateTextScale(value);
                  setState(() {});
                },
              ),
              Text(
                tr(
                  context,
                  'حجم الخط الحالي: ${(fontScale * 100).round()}٪',
                  'Current font size: ${(fontScale * 100).round()}%',
                ),
                style: const TextStyle(fontSize: 13),
              ),
            ],
          ),

          const SizedBox(height: 24),
          Text(
            tr(context, 'التجربة', 'Experience'),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          SwitchListTile(
            title: Text(
              tr(context, 'إظهار النصائح والإرشادات',
                  'Show tips and guidance'),
            ),
            subtitle: Text(
              tr(
                context,
                'عرض نصائح تحت الكاميرا وفي شاشة التدريب',
                'Show tips under the camera and in training screens',
              ),
            ),
            value: _showTips,
            onChanged: (value) {
              setState(() {
                _showTips = value;
              });
            },
          ),
          SwitchListTile(
            title: Text(
              tr(context, 'تفعيل الاهتزاز (Haptics)', 'Enable vibration'),
            ),
            subtitle: Text(
              tr(
                context,
                'للتغذية الراجعة عند التعرّف على إشارة',
                'For feedback when a sign is recognized',
              ),
            ),
            value: _enableHaptics,
            onChanged: (value) {
              setState(() {
                _enableHaptics = value;
              });
            },
          ),

          const SizedBox(height: 24),
          Text(
            tr(context, 'حول التطبيق', 'About'),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ListTile(
            leading: const Icon(Icons.star_border),
            title: Text(
              tr(
                context,
                '💙 تم تطويره بواسطة طلاب علوم الحاسب من جامعة جدة',
                '💙 Developed by Computer Science students from University of Jeddah',
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: Text(tr(context, 'إصدار التطبيق', 'App version')),
            subtitle: const Text('1.0.0 (beta)'),
          ),
        ],
      ),
    );
  }
}