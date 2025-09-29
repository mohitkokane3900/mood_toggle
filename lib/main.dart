import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => MoodModel(),
      child: const MyApp(),
    ),
  );
}

class MoodModel with ChangeNotifier {
  String _mood = 'happy';
  final Map<String, int> _counts = {'happy': 0, 'sad': 0, 'excited': 0};

  String get mood => _mood;
  Map<String, int> get counts => Map.unmodifiable(_counts);

  void setHappy() {
    _mood = 'happy';
    _counts['happy'] = (_counts['happy'] ?? 0) + 1;
    notifyListeners();
  }

  void setSad() {
    _mood = 'sad';
    _counts['sad'] = (_counts['sad'] ?? 0) + 1;
    notifyListeners();
  }

  void setExcited() {
    _mood = 'excited';
    _counts['excited'] = (_counts['excited'] ?? 0) + 1;
    notifyListeners();
  }

  String get moodImagePath {
    if (_mood == 'happy') return 'assets/happy.png';
    if (_mood == 'sad') return 'assets/sad.png';
    return 'assets/excited.png';
  }

  Color get backgroundColor {
    if (_mood == 'happy') return Colors.yellow.shade100;
    if (_mood == 'sad') return Colors.lightBlue.shade100;
    return Colors.orange.shade100;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mood Toggle Challenge',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    final model = context.watch<MoodModel>();
    return Scaffold(
      backgroundColor: model.backgroundColor,
      appBar: AppBar(title: const Text('Mood Toggle Challenge')),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'How are you feeling?',
                    style: TextStyle(fontSize: 22),
                  ),
                  const SizedBox(height: 16),
                  AspectRatio(
                    aspectRatio: 1.4,
                    child: Image.asset(
                      model.moodImagePath,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 28),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    alignment: WrapAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () => context.read<MoodModel>().setHappy(),
                        child: const Text('Happy 😊'),
                      ),
                      ElevatedButton(
                        onPressed: () => context.read<MoodModel>().setSad(),
                        child: const Text('Sad 😢'),
                      ),
                      ElevatedButton(
                        onPressed: () => context.read<MoodModel>().setExcited(),
                        child: const Text('Excited 🎉'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Selections',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _CountTile(
                        label: 'Happy',
                        count: model.counts['happy'] ?? 0,
                      ),
                      _CountTile(label: 'Sad', count: model.counts['sad'] ?? 0),
                      _CountTile(
                        label: 'Excited',
                        count: model.counts['excited'] ?? 0,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CountTile extends StatelessWidget {
  final String label;
  final int count;
  const _CountTile({required this.label, required this.count});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '$count',
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(label),
      ],
    );
  }
}
