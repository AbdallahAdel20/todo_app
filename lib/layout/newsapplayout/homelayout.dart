import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/layout/newsapplayout/newscubit/cubit.dart';
import 'package:todo/layout/newsapplayout/newscubit/states.dart';
import 'package:todo/shared/cubit/cubit.dart';

class NewsLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => Newscubit(),
      child: BlocConsumer<Newscubit, NewStates>(
        listener: (context , state) =>{},
        builder: (context , state){
          var cubit = Newscubit.get(context);

          return Scaffold(
            appBar: AppBar(
              title: Text('News App'),
              actions: [
                IconButton(
                    icon: Icon(Icons.search),
                    onPressed: (){

                    },
                )
              ],
            ),
            body: cubit.Screens[cubit.currentitem],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentitem,
              onTap: (index){
                  cubit.changescreen(index);
              },
              items: cubit.bottomitems,
            ),
          );
        },
      ),
    );
  }
}
