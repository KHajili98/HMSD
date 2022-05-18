import '../injection/src/externals.dart';
import 'pages/main/main_page.dart';
import 'router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/bottom_nav/bottom_nav_cubit.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Beer App',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouter.onGenerateRoute,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: BlocProvider(
        create: (context) => getIt<BottomNavCubit>(),
        child: const MainPage(),
      ),
    );
  }
}
