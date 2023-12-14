import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/routes.dart';
import 'dependancy.dart' as di ;

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Task Manager',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: false,
      ),
      debugShowCheckedModeBanner: false,
      navigatorKey: Get.key,
      defaultTransition: Transition.topLevel,
      transitionDuration: const Duration(milliseconds: 500),
      getPages: AllRoutes.routes,
      initialRoute: AllRoutes.splashScreen,
    );
  }
}
