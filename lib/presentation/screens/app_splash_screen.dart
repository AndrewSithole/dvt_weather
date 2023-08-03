import 'package:dvt_weather/logic/cubit/location_cubit.dart';
import 'package:dvt_weather/logic/cubit/preferences_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:dvt_weather/presentation/screens/app_home_screen.dart';
import 'package:dvt_weather/presentation/utils/colors.dart';
import 'dart:io';

import '../../logic/cubit/weather_cubit.dart';

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
    BlocProvider.of<PreferencesCubit>(context).getTheme();
    _getPosition();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }
  void _getPosition(){
    BlocProvider.of<WeatherCubit>(context).listenToLocationState();
    BlocProvider.of<LocationCubit>(context).determinePosition().then((value){
      if (mounted) finish(context);
      AppHomeScreen().launch(context, isNewTask: true);
    }).catchError((error){
      toasty(context, error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
