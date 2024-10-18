import 'package:flutter/material.dart';
import 'src/controller/utils.dart';
import 'src/view/screens/login_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('myBox');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return MaterialApp(
      title: 'Task 01',
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(seedColor:),
        useMaterial3: false,
      ),
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
    );
  }
}
