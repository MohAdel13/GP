import 'package:flutter/material.dart';
import 'package:gp_project/register.dart';
import 'package:neon_widgets/neon_widgets.dart';

class LoginScreen extends StatefulWidget
{
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool ISvisibil = false;

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
                  Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 80.0,
                      fontFamily: 'Italiano',
                      color: Colors.white
                    ),
                  ),
                  SizedBox(height: 40.0),
                  TextFormField(
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,),
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    onFieldSubmitted: (String value) {
                      print(value);
                    },
                    decoration: InputDecoration(
                      labelText: 'Email Address',
                      labelStyle: TextStyle(color: Colors.white),
                      prefixIcon: Icon(
                        Icons.email,
                        color: Colors.white,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(
                          width: 2.0,
                          color: Colors.white,
                          )),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(
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
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,),
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: !ISvisibil,
                    onFieldSubmitted: (String value) {
                      print(value);
                    },
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.white,),
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.white,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(ISvisibil ? Icons.visibility : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            ISvisibil = !ISvisibil;
                          });
                        },
                        color: Colors.white,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(
                          width: 2.0,
                          color: Colors.white,
                          )),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(
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
                  SizedBox(
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
                        onPressed: () {
                          if(formKey.currentState!.validate()){}
                          else{
                            print(emailController.text);
                            print(passwordController.text);
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
                  SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: 12.0,),
                      Text(
                        'Don\'t have an account?',
                        style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.white),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder:(context) => RegiScreen(),));
                        },
                        child: Text(
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