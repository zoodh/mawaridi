import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mawaridii/app/utilities/color_scheme.dart';
import 'package:mawaridii/routes/routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      locale: context.locale,
      theme: appTheme,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,

      routerConfig: appRouter,
    );
  }
}