import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/modules/archieved_tasks/archived_tasks_screen.dart';
import 'package:todo/modules/done_tasks/done_tasks_screen.dart';
import 'package:todo/modules/new_tasks/new_tasks_screen.dart';
import 'package:todo/shared/cubit/states.dart';

class Appcubit extends Cubit<Appstates> {
  Appcubit() : super(Appinitialstate());

  static Appcubit get(context) => BlocProvider.of(context);

  int currentItem = 0;

  List<Widget> screens = [
    Newtasksscreen(),
    Donetasksscreen(),
    Archivedtasksscreen(),
  ];

  void changeindex(int index) {
    currentItem = index;
    emit(AppChangeBottomNavstate());
  }

  Database database;
  List <Map> newtasks = [];
  List <Map> donetasks = [];
  List <Map> archivedasks = [];
  bool isBottomsheetopen = false;
  IconData fabicon = Icons.edit;


  void creatdatabase() {
    openDatabase('todo2.db', version: 1, onCreate: (database, int version) {
      print('database created');
      database
          .execute(
              'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)')
          .then((value) {
        print('table created');
      }).catchError((error) {
        print('error is ${error.toString()}');
      });
    }, onOpen: (database) {
      getdata(database);
      print("database opened");
    }).then((value) {
      database = value;
      emit(AppCreatdatabasestate());
    });
  }

  void changebottomsheetstate(@required bool isShow , @required IconData Icon){
    isBottomsheetopen = isShow;
    fabicon = Icon;
    emit(AppChangeBottomsheetstate());
  }


  insertdatabase({@required String title, @required String time, @required String date,}) async {
    await database.transaction((txn) {
      txn.rawInsert('INSERT INTO tasks (title,date,time,status) VALUES("$title","$date","$time","new")')
          .then((value) {
            print('$value record inserterd');
            emit(AppInsertdatabasestate());
            getdata(database);
          }).catchError((error) {
            print('error when inserting date  ${error.toString()}');
          });
      return null;
    });
  }

  void getdata(database)  {
    newtasks = [];
    donetasks = [];
    archivedasks = [];

    database.rawQuery('SELECT * FROM tasks').then((value) {


      value.forEach((element) {
       if(element['status' ] == 'new')
         newtasks.add(element);
       else if(element['status' ] == 'done')
         donetasks.add(element);
       else
         archivedasks.add(element);
      });

      emit(AppGetdatabasestate());
    });
  }

  void  updatedata({@required String status, @required int id,}) async {
    database.rawUpdate(
        'UPDATE tasks SET status = ?  WHERE id = ?',
        ['$status', id ]).then((value) {
          getdata(database);
          emit(AppUpdatedatabasestate());
    });

  }

  void deletedate({@required int id,}) async 
  {
    database.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
        getdata(database);
        emit(Appdeletedatabasestate());
    });
  }
}

