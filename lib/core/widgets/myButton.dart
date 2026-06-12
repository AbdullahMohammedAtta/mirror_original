import 'package:flutter/material.dart';
import 'package:mirror_original/core/utils/functions.dart';

Widget myButton(String text,context, Widget widget) =>  MaterialButton(
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.black,
          ),

          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(text,style: TextStyle(color: Colors.white,fontSize: 18)),
            ),
          )
      ),
    ),
    onPressed: ()
    {
      navigateAndFinish(context, widget);

    }
);