import '../../model/Conversa.dart';

abstract class ChatListState{}


class ChatListFetchingState extends ChatListState
{

}

class ChatListLoadedState extends ChatListState
{
  List<Conversa> conversas = [];
  ChatListLoadedState(this.conversas);
}

class ChatListErrorState extends ChatListState
{
  String errorMessage;
  ChatListErrorState(this.errorMessage);
}