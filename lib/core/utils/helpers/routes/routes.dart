import 'package:flutter/material.dart';
import 'package:sociable/features/app/app.dart';
import 'package:sociable/features/auth/auth.dart';
import 'package:sociable/features/home/screens/home_screen.dart';

List<Page<dynamic>> onGeneratePages(
    AppStatus state, List<Page<dynamic>> pages) {
  switch (state) {
    case AppStatus.authenticated:
      return [HomeScreen.page()];
    case AppStatus.unauthenticated:
      return [LoginScreen.page()];
  }
}
