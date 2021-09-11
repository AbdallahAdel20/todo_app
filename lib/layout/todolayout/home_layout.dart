import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/modules/archieved_tasks/archived_tasks_screen.dart';
import 'package:todo/modules/done_tasks/done_tasks_screen.dart';
import 'package:todo/modules/new_tasks/new_tasks_screen.dart';
import 'package:todo/shared/componants/componants.dart';
import 'package:todo/shared/componants/constants.dart';
import 'package:todo/shared/cubit/cubit.dart';
import 'package:todo/shared/cubit/states.dart';

class Homelayout extends StatelessWidget {
  var scaffoldkey = GlobalKey<ScaffoldState>();
  var formkey = GlobalKey<FormState>();

  var titlecontroller = TextEditingController();
  var timecontroller = TextEditingController();
  var datecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => Appcubit()..creatdatabase(),
      child: BlocConsumer<Appcubit, Appstates>(
        listener: (BuildContext context, Appstates state) {
          if(state is AppInsertdatabasestate){
            Navigator.pop(context);
          }
        },
        builder: (BuildContext context, Appstates state) {
          var cubit = Appcubit.get(context);
          return Scaffold(
            key: scaffoldkey,
            appBar: AppBar(
              title: Text("todoApp"),
            ),
            body: ConditionalBuilder(
              condition: true,
              builder: (context) => cubit.screens[cubit.currentItem],
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentItem,
              onTap: (index) {
                cubit.changeindex(index);
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.menu,
                  ),
                  label: 'Tasks',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.check_circle_outline,
                  ),
                  label: 'Done',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.archive_outlined,
                  ),
                  label: 'Archived',
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (cubit.isBottomsheetopen) {
                  if (formkey.currentState.validate()) {
                    cubit.insertdatabase(title: titlecontroller.text, time: timecontroller.text, date: datecontroller.text);

                    // insertdatabase(
                    //     title: titlecontroller.text,
                    //     time: timecontroller.text,
                    //     date: datecontroller.text
                    // ).then((value) {
                    //   Navigator.pop(context);
                    //   isBottomsheetopen = false;
                    //   // setState(() {
                    //   //   fabicon = Icons.edit;
                    //   // });
                    // });

                  }
                }
                else {
                  scaffoldkey.currentState
                      .showBottomSheet((context) => Container(
                            padding: EdgeInsets.all(15.0),
                            color: Colors.grey[200],
                            child: Form(
                              key: formkey,
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    defaultformfield(
                                        controller: titlecontroller,
                                        label: 'title',
                                        keyboard: TextInputType.text,
                                        preicon: Icons.title,
                                        validator: (String value) {
                                          if (value.isEmpty) {
                                            return 'title must entered';
                                          } else {
                                            return null;
                                          }
                                        }),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    defaultformfield(
                                        controller: timecontroller,
                                        label: 'time',
                                        keyboard: null,
                                        preicon: Icons.watch_later_outlined,
                                        validator: (String value) {
                                          if (value.isEmpty) {
                                            return 'time must entered';
                                          } else {
                                            return null;
                                          }
                                        },
                                        ontap: () {
                                          showTimePicker(
                                                  context: context,
                                                  initialTime: TimeOfDay.now())
                                              .then((value) {
                                            timecontroller.text = value
                                                .format(context)
                                                .toString();
                                          });
                                        }),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    defaultformfield(
                                        controller: datecontroller,
                                        label: 'date',
                                        keyboard: TextInputType.text,
                                        preicon: Icons.date_range_outlined,
                                        validator: (String value) {
                                          if (value.isEmpty) {
                                            return 'date must entered';
                                          } else {
                                            return null;
                                          }
                                        },
                                        ontap: () {
                                          showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime.now(),
                                                  lastDate: DateTime.parse(
                                                      '2021-09-01'))
                                              .then((value) {
                                            datecontroller.text =
                                                DateFormat.yMMMd()
                                                    .format(value)
                                                    .toString();
                                          });
                                        })
                                  ],
                                ),
                              ),
                            ),
                          ))
                      .closed
                      .then((value) {
                    cubit.changebottomsheetstate(false, Icons.edit);
                  });
                  cubit.changebottomsheetstate(true, Icons.add_circle);
                }
              },
              child: Icon(cubit.fabicon),
            ),
          );
        },
      ),
    );
  }
}
