import '../../model/session_user.dart';

abstract class AuthEvent{}

class StartLoginEvent extends AuthEvent
{
  
}


class LoginEvent extends AuthEvent
{
  String email="";
  String senha ="";
  LoginEvent({required this.email,required this.senha});
}

class StartRegisterEvent extends AuthEvent
{
  
}

class SignInEvent extends AuthEvent
{
  String email="";
  String nome ="";
  String senha ="";
  SignInEvent({required this.email,required this.nome,required this.senha});
}

class LogoutEvent extends AuthEvent
{

}