import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp_project/core/widgets/custom_material_button.dart';
import 'package:gp_project/features/upload/bloc/upload_cubit.dart';

import '../../bloc/upload_states.dart';

class UploadScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => UploadCubit(),
      child: BlocConsumer<UploadCubit, UploadStates>(
        builder: (BuildContext context, UploadStates state) {
          UploadCubit cubit = UploadCubit.get(context);
          return Container(
            color: Colors.black,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(6.0)
                            ),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            width: double.infinity,
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: cubit.controller,
                              cursorColor: Colors.blue,
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10.0,),
                        InkWell(
                          onTap: (){
                            cubit.pick();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(6.0)
                            ),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: const Icon(
                              Icons.upload,
                              color: Colors.white,
                              size: 40.0,
                            )
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 30.0,),
                  state is UploadSuccessState? CustomMaterialButton(
                    onPressed: (){
                      cubit.proceed(context);
                    },
                    text: 'Proceed'
                  ): const SizedBox.shrink(),
                ],
              )
            )
          );
        },
        listener: (BuildContext context, UploadStates state) {  },
      ),
    );
  }
}
