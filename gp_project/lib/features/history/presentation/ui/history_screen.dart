import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp_project/features/history/bloc/history_cubit.dart';
import 'package:gp_project/features/history/bloc/history_states.dart';
import 'package:gp_project/features/history/presentation/widgets/history_item_widget.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => HistoryCubit()..getHistory()..initPlayer(),
      child: BlocConsumer<HistoryCubit, HistoryStates>(
        builder: (BuildContext context, HistoryStates state){
          HistoryCubit cubit = HistoryCubit.get(context);
          if(state is HistoryLoadingState){
            return Center(
              child: Container(
                color: Colors.black,
                child: LoadingAnimationWidget.flickr(
                  leftDotColor: Colors.white,
                  rightDotColor: Colors.blue,
                  size: 50,
                ),
              ),
            );
          }

          else {
            return ListView.separated(
              itemBuilder: (context, index) => HistoryItemWidget(index),
              separatorBuilder: (context, index) => const SizedBox(height: 15.0,),
              itemCount: cubit.history.length
            );
          }
        },
        listener: (BuildContext context, HistoryStates state){},
      ),
    );
  }
}
