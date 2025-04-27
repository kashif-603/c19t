import 'package:flutter/material.dart';

class Reuseable extends StatelessWidget {
  String title, value;
   Reuseable({super.key ,required this.title ,required this.value });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10,right: 20,top: 5,bottom: 5),
      child: Column(

       children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

        Text(title),
        Text(value)
      ],),
         SizedBox(height: 5,),
         Divider()
       ],
      ),
    );
  }
}

