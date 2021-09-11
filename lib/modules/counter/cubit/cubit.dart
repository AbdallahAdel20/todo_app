import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/modules/counter/cubit/states.dart';

class Countercubit extends Cubit<CounterStates>{

  Countercubit() : super (counterinitial());

  static Countercubit get(context) => BlocProvider.of(context);

  int counter = 1;

  void minus (){
    counter--;
    emit(counterMinusState(counter));
  }

  void plus (){
    counter++;
    emit(counterPlusState(counter));
  }
}