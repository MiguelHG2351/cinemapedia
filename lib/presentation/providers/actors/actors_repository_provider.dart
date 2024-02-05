import 'package:cinemapedia/infrastructure/datasources/actor_moviesdb_datasource.dart';
import 'package:cinemapedia/infrastructure/repositories/actor_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actorsRepositoryProvier = Provider<ActorRepositoryImpl>((ref) {
  return ActorRepositoryImpl( datasource: ActorMovieDbDatasource() );
});