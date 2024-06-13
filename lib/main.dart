import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Bloc/SignUpBloc/signup_bloc.dart';
import 'Bloc/VerifyOtpBloc/VerifyOtpBloc.dart';
import 'app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: 'AIzaSyCWj8HY1-QKdD_wPlE66teBYPem-5XiXlg',
    appId: '1:1071073412864:android:54ef7ad9aa4191c51cd5e5',
    messagingSenderId: '506966079089',
    projectId: 'uggiso-restaurant',
    storageBucket: 'gs://uggiso-restaurant-dac53.appspot.com',
  ));
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.immersiveSticky,
    overlays: [SystemUiOverlay.bottom],
  );

  runApp(MultiBlocProvider(providers: [
    BlocProvider<SignUpBloc>(
      create: (context) => SignUpBloc(),
    ),
    BlocProvider<VerifyOtpBloc>(
      create: (context) => VerifyOtpBloc(),
    ),
  ], child: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // final NotificationService _notificationService = NotificationService();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    _firebaseMessaging.getToken().then((token) {
      print('Token: $token');
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('onMessage: ${message.messageId}');
      // Handle the notification when the app is in the foreground
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('onMessageOpenedApp: $message');
      // Handle the notification when the app is in the background and opened
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: const CupertinoPageTransitionsBuilder(),
            // For Android
            TargetPlatform.iOS: const CupertinoPageTransitionsBuilder(),
            // For iOS
          },
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.initialRoute,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    print('Handling a background message: ${message.messageId}');
    // Handle the notification when the app is in the background or terminated
  }
}
