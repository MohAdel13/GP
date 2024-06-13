import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp_project/features/history/bloc/history_cubit.dart';
import 'package:gp_project/features/history/bloc/history_states.dart';

class HistoryItemWidget extends StatelessWidget {
  final int index;
  const HistoryItemWidget(this.index);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HistoryCubit, HistoryStates>(
      builder: (BuildContext context, HistoryStates state) {
        HistoryCubit cubit = HistoryCubit.get(context);
        List<String> dateTime = '${cubit.history[index].dateTime}'.split(' ');
        return Dismissible(
          key: UniqueKey(),
          onDismissed: (direction){
            cubit.deleteHistory(index);
          },
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF35374B),
              borderRadius: BorderRadius.circular(20.0)
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            margin: const EdgeInsets.symmetric(horizontal: 20.0),
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            height: 120.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15.0,),
                Text(
                  '${dateTime[0]} at ${dateTime[1].split('.')[0]}',
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 5.0,),
                Row(
                  children: [
                    (cubit.resultState[index] == 'loading')?
                    const CircularProgressIndicator(color: Colors.blue,):
                    (cubit.resultState[index] == 'off')?
                    InkWell(
                      onTap: (){
                        cubit.startAudio(index);
                      },
                      child: const Icon(
                        Icons.play_arrow,
                        color: Colors.green,
                        size: 35.0,
                      ),
                    ):
                    InkWell(
                      onTap: (){
                        cubit.stopAudio(index);
                      },
                      child: const Icon(
                        Icons.pause,
                        color: Colors.white,
                        size: 35.0,
                      ),
                    ),

                    const Spacer(),
                    Container(
                        height: 60.0,
                        width: 60.0,
                        child: Image.asset(
                          'assets/images/${cubit.history[index].emotion.toLowerCase()}.png',
                          fit: BoxFit.contain,
                        )
                    )
                  ],
                ),
                const SizedBox(height: 15.0,),
              ],
            ),
          ),
        );
      },
      listener: (BuildContext context, HistoryStates state) {  },
    );
  }
}
