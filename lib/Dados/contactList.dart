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

  Future<List<Contato>> getAllContacts() async {
    return contactList;
  }

  Future<Contato?> getByNumber(int number) async {
    for (int i = 0; i < contactList.length; i++) {
      if (number == contactList[i].numero) {
        return contactList[i];
      }
    }
    return null;
  }

  Future<int> editContato(int id, Contato novo) async {

    contactList[id] = novo.copy();
    return 1;
  }

  Future<int> removeContato(Contato cont) async {
    for (int i = 0; i < contactList.length; i++) {
      if (cont.numero == contactList[i].numero) {
        contactList.removeAt(i);
      }
    }
    return 1;
  }
}

var contactList = [
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
  for (int i = 0; i < contactList.length; i++) {
    if (number == contactList[i].numero) {
      return contactList[i];
    }
  }
  return null;
}

void editContato(int number, Contato novo) {
  for (int i = 0; i < contactList.length; i++) {
    if (number == contactList[i].numero) {
      contactList[i] = novo.copy();
    }
  }
}

void removeContato(Contato cont) {
  for (int i = 0; i < contactList.length; i++) {
    if (cont.numero == contactList[i].numero) {
      contactList.removeAt(i);
    }
  }
}
