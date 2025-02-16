import 'package:go_router/go_router.dart';
import 'view/splash.view.dart';
import 'view/home.view.dart';
import 'view/contact.view.dart';
import 'view/post.view.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => HomeView()),
    GoRoute(path: '/splash', builder: (context, state) => SplashView()),
    GoRoute(path: '/contact', builder: (context, state) => ContactView()),
    GoRoute(path: '/post', builder: (context, state) => PostView()),
  ],
);
