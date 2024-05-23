import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp_project/core/network/local/cache_helper.dart';
import 'package:gp_project/features/home%20layout/presentation/ui/home_layout_screen.dart';

import 'login_states.dart';

class LoginCubit extends Cubit<LoginState>{
  LoginCubit():super(LoginInitState());
  bool passIsVisible = false;

  static LoginCubit get(BuildContext context) => BlocProvider.of(context);

  Future<void> login(String email, String password, BuildContext context) async {
    emit(LoginLoadingState());
    FirebaseAuth auth = FirebaseAuth.instance;

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password
      );

      final user = userCredential.user;

      CacheHelper.setData('userId', await user!.getIdToken());

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeLayoutScreen()),
      );

      emit(LoginSuccessState());

    } on FirebaseAuthException catch (error) {
      errorMessageCreate(context, error.message!);
      emit(LoginErrorState(error.message!));
    }
  }

  void errorMessageCreate(BuildContext context, String error){
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.rightSlide,
      titleTextStyle: const TextStyle(color: Colors.black),
      descTextStyle: const TextStyle(color: Colors.red),
      title: 'Login Failed..',
      desc: error,
    ).show();
  }

  void visibilityChange(){
    emit(LoginPassVisibilityChange());
    passIsVisible = !passIsVisible;
  }
}