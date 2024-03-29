import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/human_format.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';

typedef SearchMovieSCallaback = Future<List<Movie>> Function( String query );

class SearchMovieDelegate extends SearchDelegate<Movie?> {
  final SearchMovieSCallaback searchMovies;
  final List<Movie> initialMovies;
  StreamController<List <Movie>> debounceMovies = StreamController.broadcast();
  Timer? _debounceTimer;

  SearchMovieDelegate({
    required this.initialMovies,
    required this.searchMovies
  });

  void clearStreams() {
    debounceMovies.close();
  }

  void _onQueryChanged ( String query ) {
    if ( _debounceTimer?.isActive ?? false ) _debounceTimer!.cancel();

    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      // if (query.isEmpty) {
      //   debounceMovies.add([]);
      //   return ;
      // }

      final movies = await searchMovies( query );
      debounceMovies.add(movies);
    },);
  }

  @override
  String get searchFieldLabel => 'Buscar peliculas';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      FadeIn(
        animate: query.isNotEmpty,
        child: IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
          },
        ),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_rounded),
      onPressed: () {
        clearStreams();
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    _onQueryChanged(query);
    return StreamBuilder(
      stream: debounceMovies.stream,
      initialData: initialMovies,
      // future: searchMovies(query),
      builder: (context, snapshot) {
        final movies = snapshot.data ?? [];
        
        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) {
            return _MovieItem(
              onMovieSelected: (context, movie) {
                clearStreams();
                close(context, movie);
              },
              movie: movies[index]
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    _onQueryChanged(query);
    
    return StreamBuilder(
      stream: debounceMovies.stream,
      initialData: initialMovies,
      // future: searchMovies(query),
      builder: (context, snapshot) {
        final movies = snapshot.data ?? [];
        
        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) {
            return _MovieItem(
              onMovieSelected: (context, movie) {
                clearStreams();
                close(context, movie);
              },
              movie: movies[index]
            );
          },
        );
      },
    );
  }
}

class _MovieItem extends StatelessWidget {
  final Movie movie;
  final Function onMovieSelected;
  
  const _MovieItem({
    required this.movie,
    required this.onMovieSelected
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        onMovieSelected(context, movie);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            // image
            SizedBox(
              width: size.width * 0.2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  movie.posterPath,
                  loadingBuilder: (context, child, loadingProgress) => FadeIn(child: child),
                ),
              ),
            ),
      
            SizedBox(width: 10,),
      
            SizedBox(
              width: size.width * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(movie.title, style: textStyle.titleMedium),
      
                  ( movie.overview.length > 100 ) 
                    ? Text('${movie.overview.substring(0, 100)}...', style: textStyle.titleMedium)
                    : Text(movie.overview),
                  
                  Row(
                    children: [
                      Icon(Icons.star_half_outlined, color: Colors.yellow.shade800),
                      const SizedBox(width: 5,),
                      Text(
                        HumanFormat.number(movie.voteAverage, 1),
                        style: textStyle.bodyMedium?.copyWith(color: Colors.yellow.shade900)
                      )
                    ],
                  )
                ],
              ),
            ),
      
            // description
          ],
        ),
      ),
    );
  }
}
