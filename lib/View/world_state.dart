import 'package:c19t/model/WorldStateModel.dart';
import 'package:c19t/widget/reuseable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../services/stateServices.dart';
import 'countrylist.dart';

class WorldState extends StatefulWidget {
  const WorldState({super.key});

  @override
  State<WorldState> createState() => _WorldStateState();
}

class _WorldStateState extends State<WorldState> with TickerProviderStateMixin {
  late AnimationController _controller;
  bool _isLoading = true;

  final colorList = <Color>[
    Color(0Xff4285F4),
    Color(0Xff1aa260),
    Color(0Xffde5246),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..forward();

    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    StateServices stateServices = StateServices();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      body: SafeArea(
        child:  Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Expanded(
                child: FutureBuilder(
                  future: stateServices.fetchrecord(),
                  builder: (context, AsyncSnapshot<WorldStateModel> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child:Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SpinKitFadingCircle(
                              color: Colors.blue,
                              size: 50,
                              controller: _controller,
                            ),
                            SizedBox(height: 10,),
                            Text(
                              'Loading, please wait... ⏳',
                              style: TextStyle(fontSize: 18),
                            )

                          ],
                        )
                      );
                    } else {
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            PieChart(
                              dataMap: {
                                'Total': double.parse(snapshot.data!.cases.toString()),
                                'Recovered': double.parse(snapshot.data!.recovered.toString()),
                                'Deaths': double.parse(snapshot.data!.deaths.toString()),
                              },
                              chartRadius: MediaQuery.of(context).size.width / 2.2,
                              animationDuration: Duration(milliseconds: 1200),
                              chartType: ChartType.ring,
                              colorList: colorList,
                              chartValuesOptions: ChartValuesOptions(
                                showChartValuesInPercentage: true,
                              ),
                              legendOptions: LegendOptions(
                                legendPosition: LegendPosition.left,
                              ),
                            ),
                            SizedBox(height: 50),
                            Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: MediaQuery.of(context).size.height * 0.06,
                                  horizontal: 16,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Text(
                                        "Report",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                    Reuseable(title: "Total", value: snapshot.data!.cases.toString()),
                                    Reuseable(title: "Recovered", value: snapshot.data!.recovered.toString()),
                                    Reuseable(title: "Deaths", value: snapshot.data!.deaths.toString()),
                                    Reuseable(title: "Active", value: snapshot.data!.active.toString()),
                                    Reuseable(title: "Critical", value: snapshot.data!.critical.toString()),
                                    Reuseable(title: "Today Deaths", value: snapshot.data!.todayDeaths.toString()),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 30),
                            InkWell(
                              onTap: (){
                                Navigator.push(context, (MaterialPageRoute(builder: (context)=> Countrylist())));
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                  child: Text(
                                    "Track Countries",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
