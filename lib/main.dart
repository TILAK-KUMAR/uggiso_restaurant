import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Bloc/SignUpBloc/signup_bloc.dart';
import 'Bloc/VerifyOtpBloc/VerifyOtpBloc.dart';
import 'app_routes.dart';


void main() {
  runApp(
      MultiBlocProvider(
          providers: [
            BlocProvider<SignUpBloc>(
              create: (context) => SignUpBloc(),
            ),
            BlocProvider<VerifyOtpBloc>(
              create: (context) => VerifyOtpBloc(),
            ),
          ], child: const MyApp()));

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}); // Fix the constructor syntax

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: const CupertinoPageTransitionsBuilder(), // For Android
            TargetPlatform.iOS: const CupertinoPageTransitionsBuilder(), // For iOS
          },
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.initialRoute,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
