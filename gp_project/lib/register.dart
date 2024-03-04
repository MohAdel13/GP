import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gp_project/Shared/constants.dart';
import 'package:gp_project/login.dart';
import 'package:gp_project/recorder.dart';

class RegiScreen extends StatefulWidget
{
  @override
  _RegiScreenState createState() => _RegiScreenState();
}

class _RegiScreenState extends State<RegiScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cpassController = TextEditingController();

  var formKey = GlobalKey<FormState>();
  bool VISpass = false;
  bool VISconpass = false;
  String equal = '';
  late UserCredential userCredential;

  @override
  void initState() {
    super.initState();
  }
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
                    'Register',
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
                      print(value);
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
                      if(value!.isEmpty){
                        return 'Email can\'t be empty';
                      }
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
                    obscureText: !VISpass,
                    onFieldSubmitted: (String value) {
                      print(value);
                    },
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.white,),
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: Colors.white,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(VISpass ? Icons.visibility : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            VISpass = !VISpass;
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
                      else { equal = value.trimRight(); }
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
                    controller: cpassController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: !VISconpass,
                    onFieldSubmitted: (String value) {
                      print(value);
                    },
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      labelStyle: TextStyle(color: Colors.white,),
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: Colors.white,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(VISconpass ? Icons.visibility : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            VISconpass = !VISconpass;
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
                      else if(value.trimRight() != equal)
                      {return 'It doesn\'t match the password field';}
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 45.0,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      width: double.infinity,
                      child: MaterialButton(
                        onPressed: () async{
                          if(formKey.currentState!.validate()) {
                            bool err = false;
                            try {
                              FirebaseAuth auth = FirebaseAuth.instance;
                              userCredential = await auth
                                  .createUserWithEmailAndPassword(
                                  email: emailController.text,
                                  password: passwordController.text);
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'weak-password') {
                                err = true;
                                Fluttertoast.showToast(
                                    msg: "This password is weak, please choose another strong one",
                                    toastLength: Toast.LENGTH_LONG,
                                    backgroundColor: Colors.white,
                                    textColor: Colors.black,
                                    fontSize: 14.0
                                );
                              }
                              else if (e.code == 'email-already-in-use') {
                                err = true;
                                Fluttertoast.showToast(
                                    msg: "This email is used before",
                                    toastLength: Toast.LENGTH_LONG,
                                    backgroundColor: Colors.white,
                                    textColor: Colors.black,
                                    fontSize: 14.0
                                );
                              }
                            }

                            if(err == false){
                              user = userCredential;
                              await Future.delayed(const Duration(milliseconds: 500), () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(builder: (context) => RecScreen()),
                                );
                              });
                            }
                          }
                          else{

                          }
                        },
                        child: const Text(
                          'REGISTER',
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
                        'Already have an account?',
                        style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.white),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder:(context) => LoginScreen(),));
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 18.0,
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