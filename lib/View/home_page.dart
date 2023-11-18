import 'package:covid_tracker_app/Model/WorldStateModel.dart';
import 'package:covid_tracker_app/View/countries_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/src/rendering/box.dart';

import '../Services/state_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>with TickerProviderStateMixin {

  late final AnimationController _controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this)..repeat();

@override
  void dispose(){
    super.dispose();
    _controller.dispose();
  }
  
  final colorLists = <Color> [
   const Color(0xff4285f4),
    const Color(0xff1aa260),
    const Color(0xffde5246)
  ];

  @override
  Widget build(BuildContext context) {
    StateServices stateServices = StateServices();
    return Scaffold(
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
            child: Column(
              children: [
                Expanded(
                  child: FutureBuilder(
                    future: stateServices.fetchWorldStateRecords(),
                      builder: (context ,AsyncSnapshot<WorldStateModel> snapshot){
                        if(!snapshot.hasData){
                          return Expanded(
                            flex: 1,
                              child: SpinKitFadingCircle(
                                color: Colors.white,
                                size: 50,
                                controller: _controller,
                              ),
                          );

                        }else{
                          return Column(
                            children: [
                              PieChart(
                                dataMap:{
                                  "Total": double.parse(snapshot.data!.cases!.toString()),
                                  "Recovered": double.parse(snapshot.data!.recovered.toString()),
                                  "Death" : double.parse(snapshot.data!.deaths.toString()),
                                },
                                chartValuesOptions: ChartValuesOptions(
                                  showChartValuesInPercentage: true
                                ),
                                chartRadius: MediaQuery.of(context).size.width/2.8,
                                legendOptions: LegendOptions(
                                    legendPosition: LegendPosition.left
                                ),
                                animationDuration: Duration(milliseconds: 1200),
                                chartType: ChartType.ring,
                                colorList: colorLists,
                              ),
                              SizedBox(height: MediaQuery.of(context).size.width* .12,),
                              Card(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 15, top: 20, right: 15),
                                  child: Column(
                                    children: [
                                      ReuseableRow(title: "Total", value: snapshot.data!.cases.toString()),
                                      ReuseableRow(title: "Recovered", value: snapshot.data!.recovered.toString()),
                                      ReuseableRow(title: "Deaths", value: snapshot.data!.deaths.toString()),
                                      ReuseableRow(title: "Active", value: snapshot.data!.active.toString()),
                                      ReuseableRow(title: "Critical", value: snapshot.data!.critical.toString()),
                                      ReuseableRow(title: "Tests", value: snapshot.data!.tests.toString()),
                                      ReuseableRow(title: "Updated", value: snapshot.data!.updated.toString()),
                                      ReuseableRow(title: "Updated", value: snapshot.data!.updated.toString()),

                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: MediaQuery.of(context).size.height*.03,),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.green,
                                      minimumSize: Size(double.infinity, MediaQuery.of(context).size.height*0.057),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(15)
                                      )
                                  ),
                                  onPressed: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>CountriesListPage(),));
                                  },
                                  child: Text("Track Countries", style: TextStyle(fontSize: 17),)),
                              SizedBox(height: MediaQuery.of(context).size.height*.02,)
                            ],
                          );

                        }

                  }),
                ),

              ],
            ),
          )),
    );
  }
}

class ReuseableRow extends StatelessWidget {
  String title, value;
   ReuseableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title),
            Text(value),

          ],
        ),
        SizedBox(height:MediaQuery.of(context).size.height* .02,),
        Divider()
      ],
    );


  }
}

