import 'package:go_router/go_router.dart';

import 'package:todo_app/features/home/presentation/views/home_screens.dart';

abstract class AppRouter {
  static const KHomeScreen = '/homescreen';
  static const KDone = '/done';
  static const KArsheive = '/arsheive';

  static final router = GoRouter(routes: [
    GoRoute(path: '/',builder: (context, state) => const HomeScreens(),),

  ]);

}
