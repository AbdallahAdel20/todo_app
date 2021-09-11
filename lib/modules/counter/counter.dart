import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/modules/counter/cubit/cubit.dart';
import 'package:todo/modules/counter/cubit/states.dart';

class Counter extends StatelessWidget {
  // int count = 0;


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=> Countercubit(),
      child: BlocConsumer<Countercubit , CounterStates>(
        listener: (context , state) {
          if(state is counterMinusState){
            print("minus state ${state.counter}");
          }
          if(state is counterPlusState){
            print("plus state ${state.counter}");
          }
        },
        builder: (context , state){
          return Scaffold(
            appBar: AppBar(title: Text("counter"),),
            body: Center(
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MaterialButton(
                      onPressed: (){
                        Countercubit.get(context).plus();
                      },
                      child:Icon(Icons.add_circle),
                      color: Colors.blue,
                    ),
                    SizedBox(width: 10,),
                    Text("${Countercubit.get(context).counter}"),
                    SizedBox(width: 10,),
                    MaterialButton(
                      onPressed: (){
                        Countercubit.get(context).minus();
                      },
                      child: Icon(Icons.remove_circle),
                      color: Colors.blue,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
