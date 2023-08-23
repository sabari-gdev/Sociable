import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sociable/core/utils/theme/colors.dart';
import 'package:sociable/core/widgets/loader/loader_widget.dart';
import 'package:sociable/features/app/bloc/app_bloc.dart';
import 'package:sociable/features/auth/screens/screens.dart';
import 'package:sociable/features/home/home.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppBloc, AppState>(
      listener: (_, state) {
        if (state.status == AppStatus.authenticated) {
          debugPrint('authenticated');
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
          );
        } else {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ),
          );
        }
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo_black.png',
                width: 300,
                height: 300,
              ),
              const LoaderWidget(
                color: kPinkColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
