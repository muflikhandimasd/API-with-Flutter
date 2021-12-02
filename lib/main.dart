import 'package:flutter/material.dart';
import 'package:try_rest_api_flutter/screens/home_screen.dart';

void main() {
  runApp(const Application());
}

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.orange[100],
        appBarTheme: const AppBarTheme(elevation: 0.0),
      ),
      home: const HomeScreen(),
    );
  }
}
