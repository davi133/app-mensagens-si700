import 'package:UnitalkV0_2/Blocs/Authentication/auth_bloc.dart';
import 'package:UnitalkV0_2/Blocs/Authentication/auth_event.dart';
import 'package:UnitalkV0_2/Dados/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'signin_view.dart';
import 'Home.dart';
import 'dart:math';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email = "";
  String _senha = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Entrar"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //TEXT FIELD ===========================================
                  TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                    ),
                    validator: (String? inValue) {
                      if (inValue != null) {
                        if (inValue.isEmpty) {
                          return "Insira seu email";
                        }
                      }
                      return null;
                    },
                    onSaved: (String? inValue) {
                      if (inValue != null) {
                        _email = inValue;
                      }
                    },
                  ),
                  //TEXT FIELD ===========================================
                  TextFormField(
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelText: 'Senha',
                    ),
                    validator: (String? inValue) {
                      if (inValue != null) {
                        if (inValue.isEmpty) {
                          return "Insira a sua senha";
                        }
                      }
                      return null;
                    },
                    onSaved: (String? inValue) {
                      if (inValue != null) {
                        _senha = inValue;
                      }
                    },
                  ),
                  Container(
                    height: 30,
                  ),
                  //BOTÃO DE LOGIN ===============================================================
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        child: const Text("Entrar"),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            //print("form login");
                            BlocProvider.of<AuthBloc>(context)
                                .add(LoginEvent(email: _email, senha: _senha));
                          }
                          FocusManager.instance.primaryFocus?.unfocus();

                          /*Navigator.of(context)
                              .push(MaterialPageRoute(builder: (_) {
                            return const Home();
                          }));*/
                        },
                      ),
                      Container(
                        width: 20,
                      ),
                      //BOTÃO DE CADASTRO ========================================================================
                      ElevatedButton(
                        child: const Text("Cadastrar"),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) {
                                return SigninView(
                                    ab: BlocProvider.of<AuthBloc>(context));
                              },
                            ),
                          );
                        },
                      ),
                      //BOTÃO DE teste ========================================================================
                      ElevatedButton(
                        child: const Text("teste"),
                        onPressed: () async {
                          print("sadasdasdad ========== teste ============ asdasdasdasdad");
                          ChatProvider.helper.fetchChats();
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          )),
    );
  }
}
