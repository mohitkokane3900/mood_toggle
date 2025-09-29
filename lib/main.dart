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
  String get mood => _mood;

  void setHappy() {
    _mood = 'happy';
    notifyListeners();
  }

  void setSad() {
    _mood = 'sad';
    notifyListeners();
  }

  void setExcited() {
    _mood = 'excited';
    notifyListeners();
  }

  String get moodImagePath {
    if (_mood == 'happy') return 'assets/happy.png';
    if (_mood == 'sad') return 'assets/sad.png';
    return 'assets/excited.png';
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mood Toggle',
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
      appBar: AppBar(title: const Text('Mood Toggle')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('How are you feeling?', style: TextStyle(fontSize: 22)),
            const SizedBox(height: 16),
            SizedBox(
              height: 160,
              child: Image.asset(model.moodImagePath, fit: BoxFit.contain),
            ),
          ],
        ),
      ),
    );
  }
}
