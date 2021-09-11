import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/layout/newsapplayout/newscubit/states.dart';
import 'package:todo/modules/buissnes/buisnes_screen.dart';
import 'package:todo/modules/science/scienceScreen.dart';
import 'package:todo/modules/settings/settings.dart';
import 'package:todo/modules/sports/sportsScreen.dart';

class Newscubit extends Cubit<NewStates>{

  Newscubit() : super (Newsinitialstate());

  static Newscubit get (context) => BlocProvider.of(context);

  int currentitem =0;

  List<BottomNavigationBarItem> bottomitems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.business_center),
      label: 'business',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: 'Science',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: 'Settings',
    ),
  ];

  List<Widget> Screens = [
    ScienceScreen(),
    BusinessScreen(),
    SportsScreen(),
    SettingsScreen(),
  ];

  void changescreen(int index){
    currentitem = index;
    emit(NewsBottomnavstate());
  }

}