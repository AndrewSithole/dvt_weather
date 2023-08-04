import 'package:dvt_weather/presentation/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

Drawer getDrawer(BuildContext context){
  return Drawer(
    // Add a ListView to the drawer. This ensures the user can scroll
    // through the options in the drawer if there isn't enough vertical
    // space to fit everything.
    child: ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: [
        const DrawerHeader(
          decoration: BoxDecoration(
            color: appSunnyColor,
          ),
          child: Text('App menu', style: TextStyle(color: Colors.white),),
        ),
        ListTile(
          title: const Text('Search location'),
          onTap: () {
            toasty(context, "Coming soon");
          },
        ),
        ListTile(
          title: const Text('Preferences'),
          onTap: () {
            toasty(context, "Coming soon");

          },
        ),
      ],
    ),
  );
}
