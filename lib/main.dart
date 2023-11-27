import 'package:flutter/material.dart';
import 'package:flutter_app_cap12/screens/screens.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: 'login',
        routes: {
          'home': (_) => const HomeScreen(),
          'login': (_) => const LoginScreen(),
        },
        theme: ThemeData.light()
            .copyWith(scaffoldBackgroundColor: Colors.grey[300]));
  }
}
