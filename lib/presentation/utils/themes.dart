import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';

ThemeData defaultTheme = ThemeData.light().copyWith(
  scaffoldBackgroundColor: appSunnyColor,
  appBarTheme: AppBarTheme().copyWith(
    systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: defaultStatusBarColor,
        statusBarIconBrightness: Brightness.dark, // Using dark for more visibility
        statusBarBrightness: Brightness.dark // Using dark for more visibility
    )
  )
);
ThemeData cloudyTheme = ThemeData.light().copyWith(
  scaffoldBackgroundColor: appCloudyColor,
  appBarTheme: const AppBarTheme().copyWith(
    systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: appCloudyColor,
    )
  )
);
ThemeData rainyTheme = ThemeData.light().copyWith(
  scaffoldBackgroundColor: appSunnyColor,
  appBarTheme: const AppBarTheme().copyWith(
    systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: appRainyColor,
    )
  )
);