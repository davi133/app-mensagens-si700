import '../../model/session_user.dart';

abstract class AuthEvent{}

class LoginEvent extends AuthEvent
{
  String email="";
  String senha ="";
  LoginEvent({required this.email,required this.senha});
}

class LoginAnonymousEvent extends AuthEvent
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