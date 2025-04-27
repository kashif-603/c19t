import 'package:c19t/widget/reuseable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  String image;
  String name;
  int todayCases, todayDeaths, todayRecovered, active, critical, tests, recovered;

  DetailScreen({
    required this.image,
    required this.name,
    required this.todayCases,
    required this.todayDeaths,
    required this.todayRecovered,
    required this.active,
    required this.critical,
    required this.tests,
    required this.recovered,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}


class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text(widget.name),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(height: 20),

                // Circle Avatar + Name
                Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(widget.image),
                      ),
                      SizedBox(height: 10),
                      Text(widget.name, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                      Divider(thickness: 1),
                    ],
                  ),
                ),

                SizedBox(height: 20),


                Text("Today Stats", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Reuseable(title: "Today Cases", value: widget.todayCases.toString()),
                Reuseable(title: "Today Deaths", value: widget.todayDeaths.toString()),
                Reuseable(title: "Today Recovered", value: widget.todayRecovered.toString()),

                SizedBox(height: 20),


                Text("Total Stats", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Reuseable(title: "Total Cases", value: widget.recovered.toString()),
                Reuseable(title: "Active", value: widget.active.toString()),
                Reuseable(title: "Critical", value: widget.critical.toString()),

                SizedBox(height: 20),


                Text("Testing Info", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Reuseable(title: "Total Tests", value: widget.tests.toString()),
              ],
            ),
          ),
        ),


      ),
    );
  }
}
