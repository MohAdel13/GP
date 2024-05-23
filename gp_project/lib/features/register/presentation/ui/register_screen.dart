import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp_project/core/widgets/custom_material_button.dart';
import 'package:gp_project/core/widgets/custom_text_button.dart';
import 'package:gp_project/core/widgets/custom_text_form_field.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../../login/presentation/ui/login_screen.dart';
import '../../bloc/register_cubit.dart';
import '../../bloc/register_states.dart';

class RegisterScreen extends StatelessWidget
{
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (BuildContext context, RegisterState state) {},
        builder: (BuildContext context, RegisterState state) {
          RegisterCubit cubit = RegisterCubit.get(context);

          if(state is !RegisterLoadingState) {
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
                            'Register',
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
                            label: "Email Address",
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
                            label: 'password',
                            prefixIcon: const Icon(Icons.lock, color: Colors.white,),
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
                          const SizedBox(height: 20.0,),
                          CustomTextFormField(
                            controller: cPasswordController,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: !cubit.cPassIsVisible,
                            label: 'Confirm Password',
                            prefixIcon: const Icon(Icons.lock, color: Colors.white,),
                            suffixIcon: IconButton(
                              icon: Icon(
                                  cubit.passIsVisible ? Icons.visibility : Icons
                                      .visibility_off),
                              onPressed: () {
                                cubit.confVisibilityChange();
                              },
                              color: Colors.white,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Password can\'t be empty';
                              }
                              else if (value != passwordController.text) {
                                return 'It doesn\'t match the password field';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 45.0,),
                          CustomMaterialButton(
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                cubit.register(
                                    emailController.text, passwordController.text,
                                    context);
                              }
                            },
                            text: 'REGISTER',
                          ),

                          const SizedBox(height: 5.0,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(width: 12.0,),
                              const Text(
                                'Already have an account?',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.white),
                              ),
                              CustomTextButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(context,
                                        MaterialPageRoute(
                                          builder: (context) => LoginScreen(),));
                                  },
                                  text: 'Login'
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
      ),
    );
  }
}
