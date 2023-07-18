
import 'package:flutter/material.dart';
import 'package:instagram_clone/pages/auth/signin_page.dart';
import 'package:instagram_clone/pages/auth/signup_page.dart';
import 'package:instagram_clone/pages/auth/splash_page.dart';
import 'package:instagram_clone/pages/main/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Instagram Clone',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: const SplashPage(),
      home: const HomePage(),

      routes: {
        SplashPage.id: (context) => const SplashPage(),
        SignInPage.id: (context) => const SignInPage(),
        SignUpPage.id: (context) => const SignUpPage(),
        HomePage.id: (context) => const HomePage()
      },
    );
  }
}
