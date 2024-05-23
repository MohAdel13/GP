import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp_project/core/widgets/custom_material_button.dart';
import 'package:gp_project/features/result/bloc/result_cubit.dart';
import 'package:gp_project/features/result/bloc/result_states.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ResultScreen extends StatelessWidget {
  final String audio64;
  const ResultScreen({required this.audio64});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ResultCubit(audio64: audio64)..getResult(),
      child: BlocConsumer<ResultCubit, ResultStates>(
        builder: (BuildContext context, ResultStates state){
          ResultCubit cubit = ResultCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black,
              iconTheme: const IconThemeData(color: Colors.white),
            ),
            body: Container(
              color: Colors.black,
              child: Center(
                child: (state is ResultSuccessState)?Column(
                  children: [
                    const SizedBox(height: 100,),
                    const Text(
                      'Analysis Done..',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0
                      ),
                    ),
                    const SizedBox(height: 20.0,),
                    Image(
                        image: AssetImage('assets/images/${cubit.resultEmotion!.toLowerCase()}.png'),
                        fit: BoxFit.scaleDown,
                        alignment: FractionalOffset.center
                    ),
                    const SizedBox(height: 20.0,),
                    Text(cubit.resultEmotion!, style: const TextStyle(color: Colors.white)),
                    const SizedBox(height: 40.0,),
                    CustomMaterialButton(
                      onPressed: (){},
                      text: 'Save In History'
                    )
                  ],
                ):
                (state is ResultLoadingState)? LoadingAnimationWidget.flickr(
                  leftDotColor: Colors.white,
                  rightDotColor: Colors.blue,
                  size: 50,
                ): const SizedBox.shrink()
              ),
            ),
          );
        },
        listener: (BuildContext context, ResultStates state){

        },
      ),
    );
  }
}
