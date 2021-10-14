import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:petmo/screens/petmo.dart';
import 'package:petmo/services/local_notification_service.dart';

/// Receive message when app is in background solution for on message
Future<void> backgroundHandler(RemoteMessage message) async{
  print(message.data.toString());
  print(message.notification!.title);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocalNotificationService.initialize();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: 'Flutter Demo Home Page'),
        routes: {
          "red" : (_) => RedPage(),
          "green" : (_) => GreenPage(),
        },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    super.initState();

    LocalNotificationService.initialize(context);

    ///gives you the message on which user taps and it opened the app from terminated state
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if(message != null){
        final routeFromMessage = message.data["route"];
        Navigator.of(context).pushNamed(routeFromMessage);
      }
    });


    /// Foreground
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null){
        print(message.notification!.body);
        print(message.notification!.title);
      }
      LocalNotificationService.display(message);
    });

    /// When the app is in background but opened and user taps on the notification
    ///
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      final routeFromMessage = message.data["route"];
      Navigator.of(context).pushNamed(routeFromMessage);

    });
  }

  @override
  Widget build(BuildContext context){
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(18.0),
          child: Center(
            child: Text (
              "You will receive message soon",
              style: TextStyle(fontSize: 34),
            )
          ),
      ),
    );
  }
}

class RedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.red,
      body: Padding(
        padding: EdgeInsets.all(18.0),
        child: Center(child: Text ("This is red screen")),
      )
    );
  }
}

class GreenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: Colors.green,
        body: Padding(
          padding: EdgeInsets.all(18.0),
          child: Center(child: Text ("This is green screen")),
        )
    );
  }
}