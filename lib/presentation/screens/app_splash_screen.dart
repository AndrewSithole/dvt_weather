import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:dvt_weather/presentation/screens/app_home_screen.dart';
import 'package:dvt_weather/utils/colors.dart';
import 'dart:io';

class AppSplashScreen extends StatefulWidget {
  static String tag = '/AppSplashScreen';

  const AppSplashScreen({super.key});

  @override
  AppSplashScreenState createState() => AppSplashScreenState();
}

class AppSplashScreenState extends State<AppSplashScreen> {
  String connectionStatus = "";

  @override
  void initState() {
    init();
    super.initState();
  }

  Future<void> init() async {
    setStatusBarColor(appPrimaryColor, statusBarIconBrightness: Brightness.light);
    bool isOnline = await checkIfOnline();
    setState(() {
      connectionStatus = (isOnline)?"Connected!":"You are offline. Please connect to the internet to proceed";
    });
    if (mounted && isOnline) finish(context);
    AppHomeScreen().launch(context, isNewTask: true);
  }
  Future<bool> checkIfOnline() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        debugPrint('connected');
        return true;
      }
      return false;
    } on SocketException catch (_) {
      debugPrint('not connected');
      return false;
    }
  }
  @override
  void dispose() {
    setStatusBarColor(Colors.white, statusBarIconBrightness: Brightness.dark);
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appPrimaryColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(padding: EdgeInsets.only(left: 50, right: 50), child: Icon(Icons.cloudy_snowing, color: Colors.white, size: 50,),),
            24.height,
            Padding(padding: EdgeInsets.only(left: 20, right:20),
            child: Center(child: Text(connectionStatus, style: TextStyle(fontSize: 22, color: Colors.white,),),),)
          ],
        ),
      ),
    );
  }
}
