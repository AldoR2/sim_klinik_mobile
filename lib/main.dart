import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sim_klinik_mobile/routes/app_screens.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      getPages: AppScreens.screens,
    );
  }
}
