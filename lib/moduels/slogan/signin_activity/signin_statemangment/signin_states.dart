import 'package:slogan/models/signin_model/signin_model.dart';

abstract class SignInStates {}

class SignInInitialState extends SignInStates {}

class SignInLoadingState extends SignInStates {}

class SignInSuccessState extends SignInStates {
  SignInModel? signInModel;

  SignInSuccessState(this.signInModel);
}

class SignInErrorState extends SignInStates {
  SignInModel? signInErrorModel;
  String? signInError;

  SignInErrorState({this.signInError, this.signInErrorModel});
}

class SignInChangeIconState extends SignInStates {}
