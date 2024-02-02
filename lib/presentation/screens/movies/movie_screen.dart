import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movie_info_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieScren extends ConsumerStatefulWidget {
  static const name = 'movie-screen';
  final String movieId;
  
  const MovieScren({
    super.key,
    required this.movieId
  });

  @override
  MovieScrenState createState() => MovieScrenState();
}

class MovieScrenState extends ConsumerState<MovieScren> {
  @override
  void initState() {
    super.initState();

    ref.read( movieInfoProvider.notifier ).loadMovie(widget.movieId);
  }
  
  @override
  Widget build(BuildContext context) {
    final Movie? movie = ref.watch( movieInfoProvider )[widget.movieId];

    if ( movie == null ) return  Center(child: CircularProgressIndicator( strokeWidth: 2, ));

    return Scaffold(
      // appBar: AppBar(
      //   title: Text('MovieId ${widget.movieId}'),
      // ),
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: [
          _CustomSilverAppBar(movie: movie,)
        ],
      )
    );
  }
}

class _CustomSilverAppBar extends StatelessWidget {
  final Movie movie;
  
  const _CustomSilverAppBar({ required this.movie });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return SliverAppBar(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      expandedHeight: size.height * 0.7,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        title: Text(
          movie.title,
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.start,
        ),
      ),
    );
  }
}
