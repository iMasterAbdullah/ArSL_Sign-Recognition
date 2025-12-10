part of '../app.dart';

// 6) HISTORY SCREEN
//

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final history = [
      {'time': tr(context, 'اليوم - 10:30 ص', 'Today - 10:30 AM'), 'sign': mockSigns[0]},
      {'time': tr(context, 'اليوم - 10:25 ص', 'Today - 10:25 AM'), 'sign': mockSigns[1]},
      {'time': tr(context, 'أمس - 5:15 م', 'Yesterday - 5:15 PM'), 'sign': mockSigns[2]},
    ];


    return Scaffold(
      appBar: AppBar(
        title: Text(tr(context, 'سجل الإشارات', 'Sign history')),
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
                backgroundColor: Colors.indigo.withValues(alpha: 0.1),
                child: Text(
                  sign.label,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              title: Text('${sign.nameAr} / ${sign.nameEn}'),
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

