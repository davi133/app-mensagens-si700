import 'dart:ffi';
import 'dart:math';

class SessionUser{
  final String nome;
  final int numero;
  final String email;

  SessionUser({required this.nome,required this.email,required this.numero});


  @override
  String toString() {
  
    return "[Nome: $nome, Email: $email, Numero: $numero]";
  }
}