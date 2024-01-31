import 'package:flutter/material.dart';

class MovieScren extends StatelessWidget {
  static const name = 'movie-screen';
  final String movieId;
  
  const MovieScren({
    super.key,
    required this.movieId
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MovieId $movieId'),
      ),
    );
  }
}