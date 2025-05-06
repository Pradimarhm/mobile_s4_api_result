import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'controller/demoController.dart';
import 'view/demoPage.dart';
import 'view/home.dart';
import 'model/get_data_screen.dart';

void main() async {
  await GetStorage.init();
  runApp(Apiapps());
}

class MyApp extends StatelessWidget {
  final DemoController ctrl = Get.put(DemoController());

  @override
  Widget build(BuildContext context) {
    return SimpleBuilder(
      builder: (_) {
        return GetMaterialApp(
          title: 'GetX',
          theme: ctrl.theme,
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          routes: {
            '/': (context) => HomePage(),
            '/cart': (context) => DemoPage(),
          },
        );
      },
    );
  }
}

class Apiapps extends StatelessWidget {
  final DemoController ctrl = Get.put(DemoController());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GetAPI',
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      home: GetDataScreen(),
    );
  }
}
