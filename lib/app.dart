import 'package:bang_client/app_base/base.dart';
import 'package:bang_client/routes/auth/auth_provider.dart';
import 'package:bang_client/routes/auth/auth_screen.dart';
import 'package:bang_client/routes/auth/states.dart';
import 'package:bang_client/routes/home/home_scree.dart';
import 'package:bang_client/storage/settings.dart';
import 'package:bang_client/storage/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AppRoute {
  final String location;
  final WidgetBuilder builder;
  final bool authRequired;

  AppRoute(
      {required this.location,
      required this.builder,
      required this.authRequired});
}

class RoutedApp extends ConsumerStatefulWidget {
  final List<AppRoute> routes;
  final String authLocation;
  const RoutedApp({
    super.key,
    required this.routes,
    required this.authLocation,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RoutedAppState();
}

class _RoutedAppState extends ConsumerState<RoutedApp> {
  // bool referes to routes with auth enabled or disabled
  final _routes = <String, bool>{};
  final _goRoutes = <GoRoute>[];

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsNotifierProvider);

    for (var r in widget.routes) {
      _routes[r.location] = r.authRequired;
      _goRoutes.add(
        GoRoute(
          path: r.location,
          builder: (context, state) => r.builder(context),
        ),
      );
    }

    return settings.when(
      data: (settings) {
        final router = GoRouter(
          initialLocation: "/",
          redirect: (context, state) {
            if ((_routes[state.fullPath] ?? false) &&
                settings.sessionToken != "") {
              return widget.authLocation;
            }
            return null;
          },
          routes: _goRoutes,
        );
        return MaterialApp.router(routerConfig: router);
      },
      error: (err, st) => ErrorTextWidget(err: err, st: st),
      loading: () => const LoadingWidget(),
    );
  }
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return RoutedApp(
      authLocation: "/auth",
      routes: [
        AppRoute(
          location: "/auth",
          builder: (context) => const AuthScreen(),
          authRequired: false,
        ),
        AppRoute(
          location: "/",
          builder: (context) => const HomeScreen(),
          authRequired: true,
        )
      ],
    );
  }
}
