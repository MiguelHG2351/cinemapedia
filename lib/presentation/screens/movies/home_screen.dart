import 'package:cinemapedia/presentation/providers/movies/movies_providers.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_slideshow_provider.dart';
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
    ref.read(popularMoviesProvider.notifier).loadNextPage();
  }
  
  @override
  Widget build(BuildContext context) {
    final nowPlayingMovies = ref.watch( nowPlayingMoviesProvider );
    final moviesSlideshow = ref.watch( moviesSlideShowProvider );
    final popularMovies = ref.watch( popularMoviesProvider );

    if (nowPlayingMovies.isEmpty) return const Center(child: CircularProgressIndicator());

    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: EdgeInsets.symmetric(horizontal: 0),
            title: CustomAppbar(),
          ),
        ),
        
        SliverList(delegate: SliverChildBuilderDelegate(
          (context, index) {
            return Column(
              children: [
                MoviesSlideShow(movies: moviesSlideshow),
                MovieHorizontalListview(
                  movies: nowPlayingMovies,
                  title: 'En cines',
                  subTitle: 'Lunes 20',
                  loadNextPage: () => ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(),
                ),
                MovieHorizontalListview(
                  movies: nowPlayingMovies,
                  title: 'Próximamente',
                  subTitle: 'En este mes',
                  loadNextPage: () => ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(),
                ),
                MovieHorizontalListview(
                  movies: popularMovies,
                  title: 'Populares',
                  // subTitle: 'Desde siempre',
                  loadNextPage: () => ref.read(popularMoviesProvider.notifier).loadNextPage(),
                ),
                MovieHorizontalListview(
                  movies: nowPlayingMovies,
                  title: 'Mejor calificadas',
                  subTitle: 'Desde siempre',
                  loadNextPage: () => ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(),
                ),
              ]
            );
          },
          childCount: 1
        ))
        ],
    );
  }
}