import 'package:UnitalkV0_2/Blocs/Authentication/auth_bloc.dart';
import 'package:UnitalkV0_2/Blocs/Authentication/auth_state.dart';
import 'package:UnitalkV0_2/model/session_user.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'View/login_view.dart';
import 'View/Home.dart';
import 'package:bloc/bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'WhatsApp 2',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        //home: Home()
        home: BlocProvider(
          create: (ctx) => AuthBloc(AuthenticatedState(sessionUser: SessionUser(nome: "nome", email: "asd", numero: 1))),
          child: Wrapper(),
        ));
  }
}

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      bloc: BlocProvider.of<AuthBloc>(context),
      builder: ((context, state) {
        if (state is UnauthenticatedState)
        {
          return LoginView();
        }
        else
        {
          return const Home();
        }
      }),
    );
  }
}
