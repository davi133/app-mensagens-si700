import 'dart:math';

import 'package:UnitalkV0_2/Blocs/Authentication/auth_bloc.dart';
import 'package:UnitalkV0_2/Blocs/Authentication/auth_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Home.dart';

class SigninView extends StatelessWidget {
  SigninView({super.key, this.email = "", this.nome = "", this.message = ""});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String nome = "";
  String email = "";
  String senha = "";
  String message = "";
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
        title: const Text("Cadastrar"),
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
                    initialValue: nome,
                    decoration: const InputDecoration(
                      labelText: 'Nome',
                    ),
                    validator: (String? inValue) {
                      if (inValue != null) {
                        if (inValue.isEmpty) {
                          return "Insira um nome";
                        }
                      }
                      return null;
                    },
                    onSaved: (String? inValue) {
                      if (inValue != null) {
                        nome = inValue;
                      }
                    },
                  ),
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
                          return "Insira um email válido";
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
                          return "Insira uma senha";
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
                  //BOTÃO ===============================================
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        child: const Text("Cadastrar"),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            print("form signin");
                            BlocProvider.of<AuthBloc>(context).add(SignInEvent(
                                email: email, nome: nome, senha: senha));
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
                      ElevatedButton(
                        child: const Text("Voltar"),
                        onPressed: () {
                          BlocProvider.of<AuthBloc>(context)
                              .add(StartLoginEvent());
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
