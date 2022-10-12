import '../model/contato.dart';

var contactList = [
  Contato("Felipe", 1002),
  Contato("Joao", 1003),
  Contato("Pedro", 1004),
  Contato("Robson", 1005),
  Contato("Ulisses", 1010)
];

Contato? getByNumber(int number) {
  for (int i = 0; i < contactList.length; i++) {
    if (number == contactList[i].numero) {
      return contactList[i];
    }
  }
  return null;
}

void editContato(int number, Contato novo)
{
  for(int i=0;i<contactList.length;i++)
  {
    if (number == contactList[i].numero)
    {
      contactList[i] = novo.copy();
    }
  }
}

void removeContato(Contato cont)
{
  for(int i=0;i<contactList.length;i++)
  {
    if (cont.numero == contactList[i].numero)
    {
      contactList.removeAt(i);
    }
  }
}