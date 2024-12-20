import 'package:flutter/material.dart';
import 'package:newproject/features/chatgpt/presentation/page/chatgpt.dart';

import 'core/utils/themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'new App',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      darkTheme: darkTheme,
      theme: lightTheme,
      home: BotScreen(),
    );
  }
}
