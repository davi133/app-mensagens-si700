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
  LoginView({super.key, this.email = "", this.message = ""});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String email = "";
  String senha = "";
  String message;
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (message != "") {
        showDialog(
            context: context,
            builder: (_) {
              return SimpleDialog(
                title: Text(message),
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Ok"))
                ],
              );
            });
      }
    });
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
                    initialValue: email,
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
                        email = inValue;
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
                        senha = inValue;
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
                            print("enviando login event");
                            BlocProvider.of<AuthBloc>(context)
                                .add(LoginEvent(email: email, senha: senha));
                          }
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                      ),
                      Container(
                        width: 20,
                      ),
                      //BOTÃO DE CADASTRO ========================================================================
                      ElevatedButton(
                        child: const Text("Cadastrar"),
                        onPressed: () {
                          BlocProvider.of<AuthBloc>(context)
                              .add(StartRegisterEvent());
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
