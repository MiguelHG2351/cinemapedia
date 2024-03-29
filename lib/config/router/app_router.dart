import 'package:cinemapedia/presentation/screens/movies/movie_screen.dart';
import 'package:cinemapedia/presentation/screens/screens.dart';
import 'package:cinemapedia/presentation/views/views.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/home/0',
  routes: [
    GoRoute(
      path: '/home/:page',
      name: HomeScreen.name,
      builder: (context, state) {
        final pageIndex = int.parse(state.pathParameters['page'] ?? '0');
        return HomeScreen( pageIndex: pageIndex,);
      },
      routes: [
        GoRoute(
          path: 'movie/:id',
          name: MovieScren.name,
          builder: (context, state) {
            final movieId = state.pathParameters['id'] ?? 'no-id';

            return MovieScren(movieId: movieId);
          },
        )
      ]
    ),
    GoRoute(
      path: '/favorites',
      builder: (context, state) {
        return const FavoritesView();
      },
    ),

    GoRoute(
      path: '/',
      redirect: (_, __) => '/home/0',
    )


  ]
);