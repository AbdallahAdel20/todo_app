import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/shared/componants/componants.dart';
import 'package:todo/shared/cubit/cubit.dart';
import 'package:todo/shared/cubit/states.dart';

class Archivedtasksscreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Appcubit, Appstates>(
      listener: (context, state) {},
      builder: (context, state) {
        List tasks = Appcubit.get(context).archivedasks;
        return ListView.separated(
          itemBuilder: (context, index) => builditemtask(tasks[index], context),
          separatorBuilder: (context, index) => SizedBox(
            height: 10,
          ),
          itemCount: tasks.length,
        );
      },
    );
  }
}
