// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'menu.dart';
import 'game.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Tetris",
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wilkommen bei Tetris'),
        centerTitle: true,
      ),
      backgroundColor: Colors.brown[300],
      body: const Menu(),
    );
  }
}

class GameScreen extends StatelessWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Play'),
        centerTitle: true,
      ),
      backgroundColor: Colors.brown[300],
      body: const Game(),
    );
  }
}
