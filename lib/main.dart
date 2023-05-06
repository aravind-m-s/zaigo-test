import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zaigo_test/controller/address/address_bloc.dart';
import 'package:zaigo_test/controller/home/home_bloc.dart';
import 'package:zaigo_test/controller/login/login_bloc.dart';
import 'package:zaigo_test/view/screen_splash/screen_splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(),
        ),
        BlocProvider(
          create: (context) => HomeBloc(),
        ),
        BlocProvider(
          create: (context) => AddressBloc(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.purple,
          primarySwatch: Colors.purple,
        ),
        home: const ScreenSplash(),
      ),
    );
  }
}
