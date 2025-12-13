part of '../app.dart';

// 7) SIGN DETAIL SCREEN
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
        title: Text('${sign.nameAr} / ${sign.nameEn}'),
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
                backgroundColor: Colors.teal.withValues(alpha: 0.1),
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
                      tr(context, sign.nameAr, sign.nameEn),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      tr(context, sign.descriptionAr, sign.descriptionEn),
                      style: const TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              tr(context, sign.descriptionAr, sign.descriptionEn),
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            Text(
              tr(context, 'نصائح للتطبيق:', 'Tips for practice:'),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              tr(
                context,
                '• تأكد من أن اليد واضحة ضمن الكاميرا.\n'
                '• كرر الإشارة أكثر من مرة لتثبيت الحركة.\n'
                '• حاول تقليد السرعة الصحيحة ولغة الجسد.',
                'ΓÇó Make sure your hand is clearly visible in the camera.\n'
                'ΓÇó Repeat the sign multiple times to memorize it.\n'
                'ΓÇó Try to match the correct speed and body language.',
              ),
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: () => Navigator.pushNamed(context, '/detect'),
              icon: const Icon(Icons.front_hand),
              label: Text(
                tr(context, 'جرّب هذه الإشارة الآن', 'Try this sign now'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
