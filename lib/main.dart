import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:untitled1/ui/common/utils/jwt_interceptor.dart';
import 'package:untitled1/ui/router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'dtos/jwt_payload.dart';
import 'firebase_options.dart';
import 'global_variable_model.dart';
import 'package:just_audio/just_audio.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  usePathUrlStrategy();
  runApp(
    ChangeNotifierProvider(
      create: (context) => GlobalVariableModel(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget  {
  const MyApp({super.key});
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<void>? _loadJwtFuture;
  final AudioPlayer player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _loadJwtFuture = loadJwt();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      try {
        RemoteNotification? notification = message.notification;
        if (notification != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Provider.of<GlobalVariableModel>(context, listen: false).hasMessage = true;
          });

          await player.setAsset('/notification_sound.mp3');
          player.play();
        }
      } catch (e) {
        print(e);
      }
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadJwtFuture,
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        var isLoading = snapshot.connectionState != ConnectionState.done;
        return buildMaterialApp(isLoading: isLoading);
      },
    );
  }

  Future<void> loadJwt() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accessToken');
    await JwtInterceptor().parseJwt(accessToken, needToRefresh: true);
  }

  Widget buildMaterialApp({bool isLoading = false}) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: const ColorScheme.light().copyWith(
          primary: Colors.indigoAccent,
        ),
      ),
      routerConfig: appRouter,
      builder: (context, child) {
        return isLoading
            ? const Center(child: CircularProgressIndicator())
            : child!;
      },
    );
  }
}