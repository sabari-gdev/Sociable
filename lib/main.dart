import 'package:auth_repository/auth_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:sociable/core/utils/theme/colors.dart';
import 'package:sociable/core/utils/theme/styles.dart';
import 'package:sociable/features/app/app.dart';

import 'package:sociable/firebase_options.dart';
import 'package:sociable/features/auth/screens/login_screen.dart';
import 'package:user_repository/user_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final authRepo = AuthRepository();
  final userRepo = UserRepository();

  runApp(App(
    authRepository: authRepo,
    userRepository: userRepo,
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(
            color: kChromeBlackColor,
          ),
          titleTextStyle: kTitleTextStyle,
        ),
      ),
      home: const LoginScreen(),
    );
  }
}
