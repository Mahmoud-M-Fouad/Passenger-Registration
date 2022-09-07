import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../component/db.dart';
import 'cubit_states.dart';

class AppCubit extends Cubit<AppStates>
{
  AppCubit(): super (CounterInitialState());
  static AppCubit get(context) => BlocProvider.of(context);

 // int Counter = SharedClass.getCounter(key: 'SaveCounter') == null?
//  0:SharedClass.getCounter(key: 'SaveCounter');

  var cousrelist;
  void getPassenger()async
  {
    cousrelist =  await allPassenger();
    emit(AllPassengerState());
  }
  Future<String> getList()async
  {
    return await cousrelist ;
    emit(GetListState());
  }



}