import 'package:go_router/go_router.dart';
import 'models/contact.model.dart';
import 'view/contact.detail.view.dart';
import 'view/splash.view.dart';
import 'view/home.view.dart';
import 'view/contact.view.dart';
import 'view/post.view.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => SplashView()),
    GoRoute(path: '/home', builder: (context, state) => HomeView()),
    GoRoute(path: '/contact', builder: (context, state) => ContactView()),
    GoRoute(path: '/post', builder: (context, state) => PostView()),
    GoRoute(
      path: '/contact_detail',
      builder: (context, state) {
        final contact = state.extra as Contact;
        return ContactDetailView(contact: contact);
      },
    ),
  ],
);
