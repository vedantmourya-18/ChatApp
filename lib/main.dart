import 'LoadingScreen.dart';
import 'chatScreen.dart';
import 'loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Friendlist.dart';
import 'package:flutter/services.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  WidgetsApp.debugAllowBannerOverride=false;
   await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(
    MaterialApp(
        initialRoute: '/loginScreen',
        routes: {
          '/loadingScreen': (context) => loadingScreen(),
          '/FriendsList':(context)=>Friends(),
          '/loginScreen': (context) => loginScreen(),
          '/chatScreen': (context) => ChatScreen(),
        },
      )
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _initialized = false;
  bool _error = false;
  bool _loading = true;


  void initializeFlutterFire() async {
    try {
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = true;
      });

    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    if (_error) {
      return error(context);
    }

    if (!_initialized) {
      Navigator.pushNamed(context, '/loadingScreen');
    }

    return _loading?Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            backgroundImage: AssetImage('images/Chaters.png'),
            radius: 50,
          ),
          CircularProgressIndicator(
            backgroundColor: Colors.blue,
          )
        ],
      ),
    ) :
    loginScreen();
  }
  }

error(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: new Text("Error"),
        content: new Text("Something went wrong please try again"),
      ));
}

