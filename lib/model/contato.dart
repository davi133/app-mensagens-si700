class Contato {
  int id =0;//id in the local database
  String apelido = "";
  int numero = 0;//id of the other user

  Contato(this.apelido, this.numero,{this.id=0});

  @override
  String toString() {
    return "Contato [$apelido,$numero]";
  }

  Contato copy() {
    return Contato(apelido, numero);
  }
}
