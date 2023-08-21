import 'package:auth_repository/auth_repository.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sociable/core/utils/helpers/routes/routes.dart';
import 'package:sociable/core/utils/theme/colors.dart';
import 'package:sociable/core/utils/theme/styles.dart';
import 'package:sociable/features/app/bloc/app_bloc.dart';
import 'package:sociable/features/auth/screens/login_screen.dart';

class App extends StatelessWidget {
  final AuthRepository _authRepository;
  const App({
    super.key,
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authRepository,
      child: BlocProvider(
        create: (_) => AppBloc(authenticationRepository: _authRepository),
        child: AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

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
      home: FlowBuilder(
        onGeneratePages: onGeneratePages,
        state: context.select(
          (AppBloc appBloc) => appBloc.state.status,
        ),
      ),
    );
  }
}
