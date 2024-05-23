import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp_project/core/widgets/custom_material_button.dart';
import 'package:gp_project/core/widgets/custom_text_button.dart';
import 'package:gp_project/features/register/presentation/ui/register_screen.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../core/widgets/custom_text_form_field.dart';
import '../../bloc/login_cubit.dart';
import '../../bloc/login_states.dart';


class LoginScreen extends StatelessWidget
{
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=> LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        builder: (BuildContext context, LoginState state){
          LoginCubit cubit = LoginCubit.get(context);
          if(state is !LoginLoadingState) {
            return Scaffold(
              body: Form(
                key: formKey,
                child: Container(
                  decoration: const BoxDecoration(color: Colors.black),
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const Text(
                            'Login',
                            style: TextStyle(
                                fontSize: 80.0,
                                fontFamily: 'Italiano',
                                color: Colors.white
                            ),
                          ),
                          const SizedBox(height: 40.0),
                          CustomTextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            label: 'Email Address',
                            prefixIcon: const Icon(
                              Icons.email,
                              color: Colors.white,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Email can\'t be empty';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20.0,),
                          CustomTextFormField(
                            controller: passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: !cubit.passIsVisible,
                            label: 'Password',
                            prefixIcon: const Icon(
                              Icons.lock, color: Colors.white,),
                            suffixIcon: IconButton(
                              icon: Icon(
                                  cubit.passIsVisible ? Icons.visibility : Icons
                                      .visibility_off),
                              onPressed: () {
                                cubit.visibilityChange();
                              },
                              color: Colors.white,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Password can\'t be empty';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 45.0,
                          ),
                          CustomMaterialButton(
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                cubit.login(emailController.text,
                                 passwordController.text, context);
                              }
                            },
                            text: 'LOGIN',
                          ),
                          const SizedBox(height: 5.0,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(width: 12.0,),
                              const Text(
                                'Don\'t have an account?',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.white
                                ),
                              ),
                              CustomTextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context, MaterialPageRoute(
                                    builder: (context) => RegisterScreen(),)
                                  );
                                },
                                text: 'Register Now',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
          else{
            return Center(
              child: LoadingAnimationWidget.flickr(
                leftDotColor: Colors.white,
                rightDotColor: Colors.blue,
                size: 50,
              ),
            );
          }
        },
        listener: (BuildContext context, LoginState state) {  },
      ),
    );
  }
}