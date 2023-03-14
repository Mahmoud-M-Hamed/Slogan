import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slogan/models/signin_model/signin_model.dart';
import 'package:slogan/moduels/slogan/signin_activity/signin_statemangment/signin_states.dart';
import 'package:slogan/shared_helper/dio_helper/dio.dart';
import 'package:slogan/shared_helper/network/end_points.dart';

import '../../../../shared_helper/sharedpreferences_helper/sharedpreferences.dart';

class SignInCubit extends Cubit<SignInStates> {
  SignInCubit() : super(SignInInitialState());

  static SignInCubit get(context) => BlocProvider.of(context);

  SignInModel? signInModel;
  IconData? passwordIcon = Icons.visibility_off_outlined;
  bool isPasswordShown = true;

  void changePasswordIconState() {
    if (isPasswordShown == false) {
      passwordIcon = Icons.visibility_off_outlined;
      isPasswordShown = true;
    } else {
      passwordIcon = Icons.visibility_outlined;
      isPasswordShown = false;
    }
    emit(SignInChangeIconState());
  }

  Future<void> userSignIn({
    required String? email,
    required String? password,
  }) async {
    emit(SignInLoadingState());
    await DioHelper.postData(url: signIn, data: {
      "email": email,
      "password": password,
    }).then((value) async {
      signInModel = SignInModel.fromJson(value.data);
      await SharedPreferenceHelper.saveData(
          key: "token", value: value.data['data']['token']);
      emit(SignInSuccessState(signInModel));
    }).catchError((postDataError) {
      emit(SignInErrorState(
          signInErrorModel: signInModel,
          signInError: postDataError.toString()));
    });
  }
}
