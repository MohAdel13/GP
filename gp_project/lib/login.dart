import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gp_project/Shared/constants.dart';
import 'package:gp_project/recorder.dart';
import 'package:gp_project/register.dart';
import 'package:awesome_dialog/awesome_dialog.dart';


class LoginScreen extends StatefulWidget
{
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool isVisible = false;
  late UserCredential userCredential;

  @override
  Widget build(BuildContext context) {
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
                  TextFormField(
                    style: const TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,),
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    onFieldSubmitted: (String value) {
                    },
                    decoration: InputDecoration(
                      labelText: 'Email Address',
                      labelStyle: const TextStyle(color: Colors.white),
                      prefixIcon: const Icon(
                        Icons.email,
                        color: Colors.white,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(
                          width: 2.0,
                          color: Colors.white,
                          )),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(
                          width: 3.0,
                          color: Colors.blue,
                          )),
                    ),
                    validator: (value)
                      {
                        if(value!.isEmpty){return 'Email can\'t be empty';}
                        else if(value.contains('<') || value.contains('>') 
                                || !value.contains('@') || !value.contains('.')){
                          return 'Input a valid email';
                        }
                        return null;
                      },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    style: const TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,),
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: !isVisible,
                    onFieldSubmitted: (String value) {
                    },
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: const TextStyle(color: Colors.white,),
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: Colors.white,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(isVisible ? Icons.visibility : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            isVisible = !isVisible;
                          });
                        },
                        color: Colors.white,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(
                          width: 2.0,
                          color: Colors.white,
                          )),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(
                          width: 3.0,
                          color: Colors.blue,
                          )),
                    ),
                    validator: (value)
                      {
                        if(value!.isEmpty){return 'Password can\'t be empty';}
                        return null;
                      },
                  ),
                  const SizedBox(
                    height: 45.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      width: double.infinity,                 
                      child: MaterialButton(
                        onPressed: ()async{
                          if(formKey.currentState!.validate()){
                            bool err = false;
                            FirebaseAuth auth = FirebaseAuth.instance;
                            try {
                              userCredential = await auth.signInWithEmailAndPassword(
                                  email: emailController.text, password: passwordController.text);
                            } on FirebaseAuthException catch (e) {
                              err = true;
                              // ignore: use_build_context_synchronously
                              AwesomeDialog (
                                context: context,
                                dialogType: DialogType.error,
                                animType: AnimType.rightSlide,
                                titleTextStyle: const TextStyle(color: Colors.black),
                                descTextStyle: const TextStyle(color: Colors.red),
                                title: 'Login Failed..',
                                desc: "${e.message}",
                              ).show();
                            }

                            if(err == false){
                              user = userCredential;
                              await Future.delayed(const Duration(milliseconds: 500), () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => RecScreen()),
                                );
                              });
                            }
                          }
                          else{

                          }
                        },
                        child: const Text(
                          'LOGIN',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(width: 12.0,),
                      const Text(
                        'Don\'t have an account?',
                        style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.white),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder:(context) => RegiScreen(),));
                        },
                        child: const Text(
                          'Register Now',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.blue),
                        ),
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
}