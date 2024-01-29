import 'package:cinemapedia/presentation/providers/movies/movies_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {

  static const name = 'home-screen';
  
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cinemapedia', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: const _HomeViewState(),
    );
  }
}

class _HomeViewState extends ConsumerStatefulWidget {
  const _HomeViewState();

  @override
  _HomeViewStateState createState() => _HomeViewStateState();
}

class _HomeViewStateState extends ConsumerState<_HomeViewState> {

  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
  }
  
  @override
  Widget build(BuildContext context) {
    final nowPlayingMovies = ref.watch( nowPlayingMoviesProvider );

    if (nowPlayingMovies.length == 0) return const Center(child: CircularProgressIndicator());

    return ListView.builder(
      itemCount: nowPlayingMovies.length,
      itemBuilder: (context, index) {
        
        final movie = nowPlayingMovies[index];

        return ListTile(
          title: Text(movie.title),
        );
      },
    );
  }
}