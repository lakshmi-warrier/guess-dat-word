import 'package:flutter/material.dart';
import 'package:shake/shake.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final String title = 'Guess dat Word';

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(primarySwatch: Colors.cyan),
        home: MainPage(),
      );
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  static List<String> words = (nouns.take(50)).toList();
  late ShakeDetector detector;
  String word = words.first;

  @override
  void initState() {
    super.initState();

    detector = ShakeDetector.autoStart(
      onPhoneShake: () {
        final newWord = (List.of(words)
              ..remove(word)
              ..shuffle())
            .first;

        setState(() {
          word = newWord;
        });
      },
    );
  }

  @override
  void dispose() {
    detector.stopListening();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text('Guess dat Word!'),
        ),
        body: Center(
          child: Text(
            word,
            style: const TextStyle(
              fontSize: 72,
              fontWeight: FontWeight.bold,
              color: Colors.cyan,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
}
