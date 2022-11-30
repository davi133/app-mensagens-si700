import 'contato.dart';

class User {
  String nome = "";
  int numero = 0;



  User( this.nome, this.numero);

  User.fromMap(map)
  {
    nome = map['nome'];
    numero= map['number'];
  }

  @override
  String toString()
  {
    return "$nome[#$numero]";
  }

  User copy()
  {
    return User(nome, numero);
  }



}
