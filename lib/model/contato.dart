class Contato {
  String apelido = "";
  int numero = 0;

  Contato(this.apelido, this.numero);

  @override
  String toString() {
    return "Contato [$apelido,$numero]";
  }
}
