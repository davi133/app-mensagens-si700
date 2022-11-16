import '../model/Conversa.dart';

class ChatProvider {
  List<Conversa> conversas = [];

  static ChatProvider helper = ChatProvider._createInstance();
  ChatProvider._createInstance();
}
