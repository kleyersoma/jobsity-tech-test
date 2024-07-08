import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tech_assignment/src/features/presentation/bloc/search/search_bloc.dart';
import 'package:flutter_tech_assignment/src/features/presentation/bloc/series_list/series_list_bloc.dart';
import 'package:flutter_tech_assignment/src/features/presentation/bloc/series_list/series_list_event.dart';
import 'package:flutter_tech_assignment/src/routing/app_router.dart';

class TVMazeApp extends StatelessWidget {
  const TVMazeApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Glue the SettingsController to the MaterialApp.
    //
    // The ListenableBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SearchBloc(),
        ),
        BlocProvider(
          create: (context) => SeriesListBloc()..add(SeriesListFetched()),
        )
      ],
      child: MaterialApp(
        // Providing a restorationScopeId allows the Navigator built by the
        // MaterialApp to restore the navigation stack when a user leaves and
        // returns to the app after it has been killed while running in the
        // background.
        restorationScopeId: 'app',

        // Use AppLocalizations to configure the correct application title
        // depending on the user's locale.
        //
        // The appTitle is defined in .arb files found in the localization
        // directory.
        theme: ThemeData(),
        darkTheme: ThemeData.dark(),
        onGenerateRoute: (RouteSettings routeSettings) =>
            AppRouter(routeSettings).appRouter,
      ),
    );
  }
}
