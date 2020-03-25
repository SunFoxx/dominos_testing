import 'package:dominos_test/bloc/screen_bloc.dart';
import 'package:dominos_test/widgets/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'theme/app_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ScreenBloc(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: AppTheme,
        home: MainScreen(),
      ),
    );
  }
}
