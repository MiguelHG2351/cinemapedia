import 'package:cinemapedia/presentation/providers/movies/movies_providers.dart';
import 'package:cinemapedia/presentation/widget/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {

  static const name = 'home-screen';
  
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomeViewState(),
      bottomNavigationBar: CustomBottomNavigation(),
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

    if (nowPlayingMovies.isEmpty) return const Center(child: CircularProgressIndicator());

    return Column(
      children: [
        const CustomAppbar(),

        MoviesSlideShow(movies: nowPlayingMovies),
        
        MovieHorizontalListview(movies: nowPlayingMovies, title: 'En cines', subTitle: 'Lunes 20',)
      ],
    );
  }
}