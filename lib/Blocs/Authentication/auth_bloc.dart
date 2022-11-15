import 'package:bloc/bloc.dart';
import '../../model/session_user.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState>
{
  AuthBloc(AuthState initialState) : super(initialState)
  {

    /*on<LoginEvent>((event, emit) async {
      
    });*/
    
    on<SignInEvent>((event, emit) {
      //emit(AuthenticatedState( sessionUser:  SessionUser(email: event.email,nome: event.nome,numero: 1)));
    },);
    
    on<LoginAnonymousEvent>((event, emit) {
      //emit(AuthenticatedState( sessionUser:  SessionUser(email: "anon@email.com",nome: "Anonimo",numero: -69)));
    },);
    
    on<LogoutEvent>((event, emit) {
      //emit(UnauthenticatedState());
    },);
  }
  
}