import 'dart:async';
import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pole_paris_app/bloc/bloc_exports.dart';
import 'package:pole_paris_app/models/roles.dart';
import 'package:pole_paris_app/pages/home_unlogged.dart';
import 'package:pole_paris_app/pages/main_student.dart';
import 'package:pole_paris_app/pages/main_teacher.dart';
import 'package:pole_paris_app/services/app_router.dart';
import 'package:pole_paris_app/utils/notification_channels.dart';
import 'firebase_options.dart';
import 'package:pole_paris_app/styles/color.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print("Przyszła wiadomość: ${message.data}");
  final jsonMessage = json.encode(message.data);
  final decodedMessage = jsonDecode(jsonMessage);
  final title = decodedMessage['title'] as String;
  final body = decodedMessage['body'] as String;

  final androidNotificationDetails = AndroidNotificationDetails(
      channel.id, channel.name,
      channelDescription: channel.description,
      importance: Importance.max,
      priority: Priority.high,
      icon: "ic_stat_name",
      ticker: 'ticker');
  final notificationDetails =
      NotificationDetails(android: androidNotificationDetails);
  await flutterLocalNotificationsPlugin
      .show(0, title, body, notificationDetails, payload: 'item x');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.requestPermission();

  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());
  FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  runApp(PoleParisApp(
    appRouter: AppRouter(),
  ));
}

class PoleParisApp extends StatefulWidget {
  final AppRouter appRouter;
  const PoleParisApp({super.key, required this.appRouter});

  @override
  State<PoleParisApp> createState() => _PoleParisAppState();
}

class _PoleParisAppState extends State<PoleParisApp> {
  @override
  Widget build(BuildContext context) {
    precacheImage(const AssetImage('assets/img/logo.png'), context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CarnetsBloc()),
        BlocProvider(
            create: (context) =>
                UserBloc(carnetsBloc: context.read<CarnetsBloc>())
                  ..add(GetMe())),
      ],
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) => MaterialApp(
          title: 'Pole Paris App',
          theme: ThemeData(
              primaryColor: Colors.white,
              scaffoldBackgroundColor: const Color(0xFFF2F2F2),
              fontFamily: 'Satoshi',
              useMaterial3: true,
              textTheme: const TextTheme(),
              textSelectionTheme: const TextSelectionThemeData(
                cursorColor: CustomColors.inputText,
                selectionColor: Color.fromARGB(111, 128, 128, 128),
                selectionHandleColor: CustomColors.inputText,
              )),
          home: const MainPage(),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          onGenerateRoute: widget.appRouter.onGenerateRoute,
          initialRoute: '/',
          supportedLocales: const [
            Locale('pl', 'PL'),
          ],
        ),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _getStorage = GetStorage();

  redirectToPage(BuildContext context) {
    Timer(const Duration(milliseconds: 1000), () {
      final userId = _getStorage.read('token');
      if (userId == null || userId == '') {
        Navigator.of(context).pushReplacementNamed(HomeUnloggedPage.id);
      }

      final userState = context.read<UserBloc>().state;
      if (userState.user == null) {
        _getStorage.remove('token');
        Navigator.of(context).pushReplacementNamed(HomeUnloggedPage.id);
        return;
      }

      if (userState.user!.role == Role.teacher) {
        Navigator.of(context).pushReplacementNamed(MainPageTeacher.id);
      } else {
        Navigator.of(context).pushReplacementNamed(MainPageStudent.id);
      }
    });
  }

  @override
  void initState() {
    redirectToPage(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: CustomColors.text,
        ),
      ),
    );
  }
}
