import 'package:flutter/material.dart';
import 'package:todo/shared/cubit/cubit.dart';

Widget defaultbuttonField(
        {double width = double.infinity,
        Color color = Colors.blue,
        @required Function function,
        @required String text}) =>
    Container(
      color: color,
      width: width,
      child: MaterialButton(
        onPressed: function,
        child: Text(text),
      ),
    );

Widget defaultformfield(
        {@required TextEditingController controller,
        @required String label,
        @required TextInputType keyboard,
        @required IconData preicon,
        @required Function validator,
        Function onsubmit,
        Function onchange,
        IconData suficon,
        bool password = false,
        Function onpassword,
        Function ontap}) =>
    TextFormField(
      controller: controller,
      keyboardType: keyboard,
      onFieldSubmitted: onsubmit,
      onChanged: onchange,
      onTap: ontap,
      validator: validator,
      obscureText: password,
      decoration: InputDecoration(
        prefixIcon: Icon(preicon),
        suffixIcon: suficon!=null ? IconButton(icon: Icon(suficon),onPressed: onpassword,) : null,
        labelText: label,
        border: OutlineInputBorder(),
      ),
    );

Widget builditemtask(Map model , context)=>Dismissible(
  key: Key(model['id'].toString()),
  onDismissed: (direction){
    Appcubit.get(context).deletedate(id: model['id']);
  },
  child:Padding(
  
    padding: EdgeInsets.all(10),
  
    child: Row(
  
      children: [
  
        CircleAvatar(
  
          radius: 35,
  
          child: Text("${model['time']}"),
  
  
  
        ),
  
        SizedBox(width: 10,),
  
        Expanded(
  
          child: Column(
  
            mainAxisSize: MainAxisSize.min,
  
            crossAxisAlignment: CrossAxisAlignment.start,
  
            children: [
  
              Text("${model['title']}",
  
              style: TextStyle(
  
                fontSize: 30,
  
                fontWeight: FontWeight.bold
  
              ),),
  
              Text("${model['date']}",
  
                style: TextStyle(
  
                    fontSize: 20,
  
  
  
                ),),
  
  
  
            ],
  
          ),
  
        ),
  
        SizedBox(width: 10,),
  
        IconButton(icon: Icon(Icons.check_circle), onPressed: (){
  
            Appcubit.get(context).updatedata(status: 'done', id: model['id']);
  
        }),
  
        IconButton(icon: Icon(Icons.archive), onPressed: (){
  
            Appcubit.get(context).updatedata(status: 'archived', id: model['id']);
  
        }),
  
      ],
  
    ),
  
  ),
);