part of '../app.dart';

// 5) PRACTICE SIGNS SCREEN
//

class PracticeScreen extends StatelessWidget {
  const PracticeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr(context, 'تدريب الإشارات', 'Practice signs')),
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
                backgroundColor: Colors.teal.withValues(alpha: 0.1),
                child: Text(
                  sign.label,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              title: Text(tr(context, sign.nameAr, sign.nameEn)),
              subtitle: Text(tr(context, sign.categoryAr, sign.categoryEn)),
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

