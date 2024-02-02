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

    if ( movie == null ) return  const Center(child: CircularProgressIndicator( strokeWidth: 2, ));

    return Scaffold(
      // appBar: AppBar(
      //   title: Text('MovieId ${widget.movieId}'),
      // ),
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          _CustomSilverAppBar(movie: movie,),
          SliverList(delegate: SliverChildBuilderDelegate(
            (context, index) => _MovieDetails(movie: movie),
            childCount: 1
          ))
        ],
      )
    );
  }
}

class _MovieDetails extends StatelessWidget {
  final Movie movie;
  
  const _MovieDetails({
    required this.movie
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyles = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  movie.posterPath,
                  width: size.width * 0.3,
                ),
              ),
              const SizedBox(width: 10,),
              SizedBox(
               width: (size.width - 40) * 0.7, 
               child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(movie.title, style: textStyles.titleLarge,),
                  Text(movie.overview,),
                ],
               ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Wrap(
            children: [
              ...movie.genreIds.map((gender) => Container(
                margin: const EdgeInsets.only(right: 10),
                child: Chip(
                  label: Text(gender),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )
                ),
              ))
            ],
          ),
        ),
        
        const SizedBox(height: 100,),
      ],
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
          style: const TextStyle(fontSize: 20),
          textAlign: TextAlign.start,
        ),
        background: Stack(
          children: [
            SizedBox.expand(
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox.expand(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.7, 1],
                    colors: [
                      Colors.transparent,
                      Colors.black87,
                    ]
                  )
                ),
              ),
            ),
            const SizedBox.expand(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    stops: [0.0, 0.3],
                    colors: [
                      Colors.black87,
                      Colors.transparent,
                    ]
                  )
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
