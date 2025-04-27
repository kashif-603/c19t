import 'package:c19t/services/stateServices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'Detail_screen.dart';

class Countrylist extends StatefulWidget {
  const Countrylist({super.key});

  @override
  State<Countrylist> createState() => _CountrylistState();
}

class _CountrylistState extends State<Countrylist> {
  StateServices stateServices = StateServices();
  TextEditingController searchctrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                onChanged: (value){
                  setState(() {

                  });
                },
                controller: searchctrl,
                decoration: InputDecoration(
                  hintText: "Search with countries names",
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<dynamic>>(
                future: stateServices.fetchCountries(),
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                  if (!snapshot.hasData) {
                    // Show shimmer effect when data is loading
                    return ListView.builder(
                      itemCount: 10, // Show 10 shimmer items for loading
                      itemBuilder: (context, index) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey[700]!,
                          highlightColor: Colors.grey[100]!,
                          child: Column(
                            children: [
                              ListTile(
                                leading: Container(
                                  height: 40,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                title: Container(
                                  height: 10,
                                  width: 100,
                                  color: Colors.white,
                                ),
                                subtitle: Container(
                                  height: 10,
                                  width: 150,
                                  margin: EdgeInsets.only(top: 5),
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        );

                      },
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else {
                    // Display list once data is fetched
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        String name = snapshot.data![index]['country'];

                        // Check if the search field is empty or name contains search text
                        if (searchctrl.text.isEmpty) {
                          // Show all countries if nothing is searched
                          return InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder:(context) =>
                                  DetailScreen(
                                    name: snapshot.data![index]['country'],
                                    image: snapshot.data![index]['countryInfo']['flag'],
                                    todayCases: snapshot.data![index]['todayCases'],
                                    todayDeaths: snapshot.data![index]['todayDeaths'],
                                    todayRecovered: snapshot.data![index]['todayRecovered'],
                                    active: snapshot.data![index]['active'],
                                    critical: snapshot.data![index]['critical'],
                                    tests: snapshot.data![index]['tests'],
                                    recovered: snapshot.data![index]['recovered'],
                                  ),
                              ),
                              );
                            },
                            child: ListTile(
                              leading: Image.network(
                                snapshot.data![index]['countryInfo']['flag'],
                                height: 40,
                                width: 50,
                              ),
                              title: Text(snapshot.data![index]['country']),
                              subtitle: Text('Cases: ${snapshot.data![index]['cases']}'),
                            ),
                          );
                        } else if (name.toLowerCase().contains(searchctrl.text.toLowerCase())) {
                          // Show filtered countries
                          return InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder:(context) =>
                                  DetailScreen(
                                    name: snapshot.data![index]['country'],
                                    image: snapshot.data![index]['countryInfo']['flag'],
                                    todayCases: snapshot.data![index]['todayCases'],
                                    todayDeaths: snapshot.data![index]['todayDeaths'],
                                    todayRecovered: snapshot.data![index]['todayRecovered'],
                                    active: snapshot.data![index]['active'],
                                    critical: snapshot.data![index]['critical'],
                                    tests: snapshot.data![index]['tests'],
                                    recovered: snapshot.data![index]['recovered'],
                                  ),
                              ),
                              );
                            },
                            child: ListTile(

                              leading: Image.network(
                                snapshot.data![index]['countryInfo']['flag'],
                                height: 40,
                                width: 50,
                              ),
                              title: Text(snapshot.data![index]['country']),
                              subtitle: Text('Cases: ${snapshot.data![index]['cases']}'),
                            ),
                          );
                        } else {
                          // Don't show anything if the name doesn't match the search
                          return Container();
                        }
                      },
                    );

                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
