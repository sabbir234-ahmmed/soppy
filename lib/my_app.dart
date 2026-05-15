import 'package:e_commerce/bindings/bindings.dart';
import 'package:e_commerce/routes/app_routes.dart';
import 'package:e_commerce/utils/constants/colors.dart';
import 'package:e_commerce/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: UAppTheme.lightTheme,
      darkTheme: UAppTheme.darkTheme,
      /// routing
      getPages: UAppRoutes.screens,

      initialBinding: UBindings(),
      home: Scaffold(
        backgroundColor: UColors.primary,
        body: Center(
          child: CircularProgressIndicator(
            color: UColors.white,
          ),
        ),
      ),
    );
  }
}