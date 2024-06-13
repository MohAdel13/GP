import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp_project/features/record/bloc/record_cubit.dart';
import 'package:gp_project/features/record/bloc/record_states.dart';
import 'package:siri_wave/siri_wave.dart';

class RecordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RecordCubit(),
      child: BlocConsumer<RecordCubit, RecordStates>(
        builder: (BuildContext context, RecordStates state) {
          RecordCubit cubit = RecordCubit.get(context);
          return Container(
              color: Colors.black,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    (state is RecordStartState)? const Text(
                      'Listening...',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 70.0,
                          fontFamily: 'Italiano'),
                    ) :
                    AnimatedTextKit(
                      animatedTexts: [
                        TyperAnimatedText(
                          'Hi there!',
                          textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 70.0,
                              fontFamily: 'Italiano'),
                          speed: const Duration(milliseconds: 250),
                        ),
                      ],
                      totalRepeatCount: 1,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    (state is RecordStartState) ? SiriWaveform.ios9(
                        controller: IOS9SiriWaveformController(
                          amplitude: 1,
                          speed: 0.1,
                        ),
                        options: const IOS9SiriWaveformOptions(
                          height: 100,
                          width: double.infinity,
                        )
                    ): const SizedBox.shrink(),
                    Container(
                      width: 85,
                      height: 85,
                      margin: const EdgeInsets.all(30.0),
                      decoration: BoxDecoration(
                          color: const Color(0xFF35374B),
                          borderRadius: BorderRadius.circular(60.0)
                      ),
                      child: InkWell(
                        onTap: () {
                          cubit.startRecord();
                          Future.delayed(
                              const Duration(seconds: 5)
                          ).then((value){
                            cubit.stopRecord(context);
                            return null;
                          });
                        },
                        child: Icon(
                          Icons.mic,
                          color: (state is RecordStartState) ? Colors.blue : Colors.white,
                          size: 55.0,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
        },
        listener: (BuildContext context, RecordStates state) {  },
      ),
    );
  }
}
