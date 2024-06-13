import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp_project/features/home%20layout/bloc/home_states.dart';
import 'package:gp_project/features/record/presentation/ui/record_screen.dart';

import '../../history/presentation/ui/history_screen.dart';
import '../../upload/presentation/ui/upload_screen.dart';

class HomeCubit extends Cubit<HomeStates>{
  HomeCubit(): super(HomeInitState());

  Widget currentScreen = RecordScreen();

  List<Widget> screens = [
    RecordScreen(),
    UploadScreen(),
    HistoryScreen()
  ];

  static HomeCubit get(BuildContext context) => BlocProvider.of(context);

  void changeScreen(int id){
    currentScreen = screens[id];
    emit(HomeScreenChangeState());
  }
}