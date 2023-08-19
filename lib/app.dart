import 'package:flutter/material.dart';
import 'package:instagram_clone/presentation/pages/screens/auth/signin_page.dart';
import 'package:instagram_clone/presentation/pages/screens/auth/signup_page.dart';
import 'package:instagram_clone/presentation/pages/screens/auth/splash_page.dart';
import 'package:instagram_clone/presentation/pages/screens/main/home_page.dart';

class InstagramCloneApp extends StatelessWidget {
  const InstagramCloneApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Instagram Clone',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: const SplashPage(),
      home: const SplashPage(),

      routes: {
        SplashPage.id: (context) => const SplashPage(),
        SignInPage.id: (context) => const SignInPage(),
        SignUpPage.id: (context) => const SignUpPage(),
        HomePage.id: (context) =>  const HomePage()
      },
    );
  }
}
