import '../model/contato.dart';

class ContactDataProvider {
  var contactList = [
    Contato("Felipe Araujo Santos Pinto", 169401, id: 0),
    Contato("Davi Pereira Bergamin", 169753, id: 1),
    Contato("Joao", 1003, id: 2),
    Contato("Pedro", 1004, id: 3),
    //Contato("Robson", 1005),
    Contato("Ulisses", 1010, id: 4)
  ];

  static ContactDataProvider helper = ContactDataProvider._createInstance();

  ContactDataProvider._createInstance();

  Future<List<Contato>> getContacts() async {
    await Future.delayed(const Duration(seconds: 1));
    return [...contactList];
  }

  Future<int> addContato(Contato cont) async
  {
    await Future.delayed(const Duration(milliseconds: 500));
    contactList.add(cont);
    return 1;
  }

  Future<Contato?> getByNumber(int number) async {
    for (int i = 0; i < contactList.length; i++) {
      if (number == contactList[i].numero) {
        return contactList[i];
      }
    }
    return null;
  }

  Future<int> editContato(Contato novo) async {
    await Future.delayed(const Duration(milliseconds: 500));
    for (int i = 0; i < contactList.length; i++)
    {
      if (novo.id == contactList[i].id)
      {
        contactList[i] = novo;
        return 1;
      }
    }
    return 0;
  }

  Future<int> removeContato(Contato cont) async {
    await Future.delayed(const Duration(milliseconds: 500));
    for (int i = 0; i < contactList.length; i++) {
      if (cont.numero == contactList[i].numero) {
        contactList.removeAt(i);
        return 1;
      }
    }
    return 0;
  }
}














var contactListDeprecated = [
  //done
  Contato("Felipe Araujo Santos Pinto", 169401),
  Contato("Davi Pereira Bergamin", 169753),
  Contato("Joao", 1003),
  Contato("Pedro", 1004),
  //Contato("Robson", 1005),
  Contato("Ulisses", 1010)
];

Contato? getByNumber(int number) {
  //done
  for (int i = 0; i < contactListDeprecated.length; i++) {
    if (number == contactListDeprecated[i].numero) {
      return contactListDeprecated[i];
    }
  }
  return null;
}

void editContato(int number, Contato novo) {
  for (int i = 0; i < contactListDeprecated.length; i++) {
    if (number == contactListDeprecated[i].numero) {
      contactListDeprecated[i] = novo.copy();
    }
  }
}

void removeContato(Contato cont) {
  for (int i = 0; i < contactListDeprecated.length; i++) {
    if (cont.numero == contactListDeprecated[i].numero) {
      contactListDeprecated.removeAt(i);
    }
  }
}
