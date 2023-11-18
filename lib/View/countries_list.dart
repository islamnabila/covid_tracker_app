import 'package:covid_tracker_app/View/detail_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../Services/state_services.dart';

class CountriesListPage extends StatefulWidget {
  const CountriesListPage({super.key});

  @override
  State<CountriesListPage> createState() => _CountriesListPageState();
}

class _CountriesListPageState extends State<CountriesListPage> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    StateServices stateServices = StateServices();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),

      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                onChanged: (value){
                  setState(() {

                  });
                },
                controller: searchController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  hintText: "Search country name",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50)
                  )
                ),
              ),
            ),

            Expanded(
              child: FutureBuilder(
                future: stateServices.countrieslistApi(),
                  builder: (context, AsyncSnapshot<List<dynamic>> snapshot){
                if(!snapshot.hasData){
                  return ListView.builder(
                      itemCount: 6,
                      itemBuilder: (context, index){
                        return Shimmer.fromColors(
                            baseColor: Colors.grey.shade700,
                            highlightColor: Colors.grey.shade100,
                            child: Column(
                              children: [
                                ListTile(
                                  leading: Container(
                                    height : MediaQuery.of(context).size.width*0.14,
                                    width : MediaQuery.of(context).size.width*0.14,
                                    color: Colors.white,
                                  ),
                                  title: Container(
                                    height: MediaQuery.of(context).size.width*0.03,
                                  width: MediaQuery.of(context).size.width*.10,
                                  color: Colors.white,),

                                  subtitle:  Container(
                                    height: MediaQuery.of(context).size.width*0.03,
                                    width: MediaQuery.of(context).size.width*.10,
                                  color: Colors.white,),
                                )
                              ],
                            ),

                            );

                      });
                }else{
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                      itemBuilder: (context, index){

                        String name = snapshot.data![index]['country'];

                        if(searchController.text.isEmpty){
                          return Column(
                            children: [
                              InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailScreen(
                                      name: snapshot.data![index]["country"],
                                      image: snapshot.data![index]["countryInfo"]["flag"],
                                      totalCases: snapshot.data![index]["cases"],
                                      totalRecovered: snapshot.data![index]["recovered"],
                                      totalDeath: snapshot.data![index]["deaths"],
                                      active: snapshot.data![index]["active"],
                                      critical: snapshot.data![index]["critical"],
                                      tests: snapshot.data![index]["tests"])));
                                },
                                child: ListTile(
                                  leading: Image(
                                    height : MediaQuery.of(context).size.width*0.14,
                                    width : MediaQuery.of(context).size.width*0.14,
                                    image: NetworkImage(snapshot.data![index]['countryInfo']['flag']),
                                  ),
                                  title: Text(snapshot.data![index]["country"]),
                                  subtitle: Text(snapshot.data![index]["cases"].toString()),
                                ),
                              )
                            ],
                          );

                        }else if(name.toLowerCase().contains(searchController.text.toLowerCase())){
                          return Column(
                            children: [
                              InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailScreen(
                                      name: snapshot.data![index]["country"],
                                      image: snapshot.data![index]["countryInfo"]["flag"],
                                      totalCases: snapshot.data![index]["cases"],
                                      totalRecovered: snapshot.data![index]["recovered"],
                                      totalDeath: snapshot.data![index]["deaths"],
                                      active: snapshot.data![index]["active"],
                                      critical: snapshot.data![index]["critical"],
                                      tests: snapshot.data![index]["tests"])));
                                },

                                child: ListTile(
                                  leading: Image(
                                    height : MediaQuery.of(context).size.width*0.14,
                                    width : MediaQuery.of(context).size.width*0.14,
                                    image: NetworkImage(snapshot.data![index]['countryInfo']['flag']),
                                  ),
                                  title: Text(snapshot.data![index]["country"]),
                                  subtitle: Text(snapshot.data![index]["cases"].toString()),
                                ),
                              )
                            ],
                          );
                        }else{
                          return Container();
                        }
                  });
                }

              }),
            )


          ],
        ),
      ),

    );
  }
}
