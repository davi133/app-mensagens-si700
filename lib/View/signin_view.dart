import 'package:UnitalkV0_2/Blocs/Authentication/auth_bloc.dart';
import 'package:UnitalkV0_2/Blocs/Authentication/auth_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Home.dart';

class SigninView extends StatelessWidget {
  SigninView({super.key, required this.ab});
  AuthBloc ab;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _nome ="";
  String _email ="";
  String _senha = "";
  @override
  Widget build(BuildContext context) {
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
                       if (inValue != null)
                      {
                        _nome = inValue;
                      }
                    },
                  ),
                  //TEXT FIELD ===========================================
                  TextFormField(
                    keyboardType: TextInputType.text,
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
                       if (inValue != null)
                      {
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
                          return "Insira uma senha";
                        }
                      }
                      return null;
                    },
                    onSaved: (String? inValue) {
                      if (inValue != null)
                      {
                        _senha = inValue;
                      }
                    },
                  ),
                  Container(
                    height: 30,
                  ),
                  //BOTÃO ===============================================
                  ElevatedButton(
                    child: const Text("Cadastrar"),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        print("form signin");
                        _formKey.currentState!.save();
                        ab.add(SignInEvent(email: _email, nome: _nome, senha: _senha));
                      }
                      Navigator.of(context).pop();
                      FocusManager.instance.primaryFocus?.unfocus();
                      /*Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) {
                        return const Home();
                      }));*/
                    },
                  )
                ],
              ),
            ),
          )),
    );
  }
}
