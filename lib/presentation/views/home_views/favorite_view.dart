import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Movies'),
      ),
      body: const Center(
        child: Text('Favorite tab'),
      ),
    );
  }
}