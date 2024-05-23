import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp_project/core/network/local/cache_helper.dart';
import 'package:gp_project/features/register/bloc/register_states.dart';

import '../../home layout/presentation/ui/home_layout_screen.dart';

class RegisterCubit extends Cubit<RegisterState>{
  RegisterCubit():super(RegisterInitState());
  bool passIsVisible = false;
  bool cPassIsVisible = false;

  static RegisterCubit get(BuildContext context) => BlocProvider.of(context);

  Future<void> register(String email, String password, BuildContext context) async {
    emit(RegisterLoadingState());
    FirebaseAuth auth = FirebaseAuth.instance;

    try {
      final UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password
      );

      final user = userCredential.user;
      CacheHelper.setData('userId', await user!.getIdToken());

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeLayoutScreen()),
      );

      emit(RegisterSuccessState());

    } on FirebaseAuthException catch (error) {
      errorMessageCreate(context, error.message!);
      emit(RegisterErrorState(error.message!));
    }

  }

  void errorMessageCreate(BuildContext context, String error){
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.rightSlide,
      titleTextStyle: const TextStyle(color: Colors.black),
      descTextStyle: const TextStyle(color: Colors.red),
      title: 'Register Failed..',
      desc: error,
    ).show();
  }

  void visibilityChange(){
    emit(RegisterPassVisibilityChange());
    passIsVisible = !passIsVisible;
  }

  void confVisibilityChange(){
    emit(RegisterConfPassVisibilityChange());
    cPassIsVisible = !cPassIsVisible;
  }
}