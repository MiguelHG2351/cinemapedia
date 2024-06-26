
import 'package:cinemapedia/presentation/providers/movies/initial_loading_provider.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_providers.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_slideshow_provider.dart';
import 'package:cinemapedia/presentation/widget/movies/movie_horizontal_listview.dart';
import 'package:cinemapedia/presentation/widget/movies/movies_slideshow.dart';
import 'package:cinemapedia/presentation/widget/shared/custom_appbar.dart';
import 'package:cinemapedia/presentation/widget/shared/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {

  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(upComingMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
  }
  
  @override
  Widget build(BuildContext context) {
    final initialLoading = ref.watch(initialLoadingProvider);

    if( initialLoading) return const FullScreenLoader();

    final nowPlayingMovies = ref.watch( nowPlayingMoviesProvider );
    final moviesSlideshow = ref.watch( moviesSlideShowProvider );
    final popularMovies = ref.watch( popularMoviesProvider );
    final upComingMovies = ref.watch( upComingMoviesProvider );
    final topRatedMovies = ref.watch( topRatedMoviesProvider );

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
                  movies: upComingMovies,
                  title: 'Próximamente',
                  subTitle: 'En este mes',
                  loadNextPage: () => ref.read(upComingMoviesProvider.notifier ).loadNextPage(),
                ),
                MovieHorizontalListview(
                  movies: popularMovies,
                  title: 'Populares',
                  // subTitle: 'Desde siempre',
                  loadNextPage: () => ref.read(popularMoviesProvider.notifier).loadNextPage(),
                ),
                MovieHorizontalListview(
                  movies: topRatedMovies,
                  title: 'Mejor calificadas',
                  // subTitle: 'Desde siempre',
                  loadNextPage: () => ref.read(topRatedMoviesProvider.notifier).loadNextPage(),
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