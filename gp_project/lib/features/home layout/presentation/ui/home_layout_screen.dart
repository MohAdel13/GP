import 'package:circular_menu/circular_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp_project/core/network/local/cache_helper.dart';
import 'package:gp_project/core/widgets/custom_circular_menu_item.dart';
import 'package:gp_project/features/home%20layout/bloc/home_cubit.dart';
import 'package:gp_project/features/home%20layout/bloc/home_states.dart';
import '../../../login/presentation/ui/login_screen.dart';
class HomeLayoutScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () async{
            await FirebaseAuth.instance.signOut();
            await CacheHelper.removeData('userId').then((value){
              print (value);
            });
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>LoginScreen()));
            },
            icon: const Row(
              children: [
                Text('Logout ', style: TextStyle(color: Colors.white, fontSize: 18.0),),
                Icon(Icons.exit_to_app, size: 40.0,)
              ],
            ),
            color: Colors.white,
          )
        ],
      ),
      body: BlocProvider(
        create: (BuildContext context) => HomeCubit(),
        child: BlocConsumer<HomeCubit, HomeStates>(
          builder: (BuildContext context, HomeStates state) {
            HomeCubit cubit = HomeCubit.get(context);
            return Column(
              children: [
                Expanded(
                  child: Container(
                    color: Colors.black,
                    child: cubit.currentScreen,
                  )
                ),
                Container(
                  color: Colors.black,
                  padding: const EdgeInsets.all(10.0),
                  height: 180.0,
                  child: CircularMenu(
                    toggleButtonColor: Colors.grey.withOpacity(0.2),
                    toggleButtonSize: 30,
                    toggleButtonBoxShadow: const [],
                    alignment: Alignment.bottomRight,
                    items: [
                      CustomCircularMenuItem(
                        (){
                          cubit.changeScreen(0);
                        },
                        Icons.keyboard_voice,
                      ),
                      CustomCircularMenuItem(
                        (){
                          cubit.changeScreen(1);
                        },
                        Icons.upload,
                      ),
                      CustomCircularMenuItem(
                        (){
                          cubit.changeScreen(2);
                        },
                        Icons.history,
                      ),
                    ],
                  ),
                )
              ],
            );
          },
          listener: (BuildContext context, HomeStates state) {  },
        ),
      ),
    );
  }
}