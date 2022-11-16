import 'cha_list_event.dart';
import 'cha_list_state.dart';
import 'package:bloc/bloc.dart';

class ChatListBloc extends Bloc<ChatListEvent,ChatListState>
{
  ChatListBloc(ChatListState initialstate) : super(initialstate){
      on<ChatListFetchEvent>((event, emit) {
        
      },);

      on<ChatListAddEvent>((event, emit) {
        
      },);
  }
  
}
