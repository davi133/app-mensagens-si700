import 'Blocs/Authentication/auth_bloc.dart';
import 'Blocs/Authentication/auth_state.dart';
import 'model/session_user.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'View/login_view.dart';
import 'View/Home.dart';
import 'package:bloc/bloc.dart';
import 'router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final AppRouter _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(UnauthenticatedState()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'WhatsApp 2',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        //home: Home()
        home: const Wrapper(),
      ),
    );
  }
}

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      bloc: BlocProvider.of<AuthBloc>(context),
      builder: ((context, state) {
        if (state is UnauthenticatedState) {
          return LoginView();
        } else {
          return const Home();
        }
      }),
    );
  }
}
