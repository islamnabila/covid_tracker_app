import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

class DetailScreen extends StatefulWidget {
  String name, image;
  int totalCases, totalRecovered, totalDeath, active, critical, tests;

   DetailScreen({
    required this.name,
     required this.image,
     required this.totalCases,
     required this.totalRecovered,
     required this.totalDeath,
     required this.active,
     required this.critical,
     required this.tests
});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
             Stack(
               alignment: Alignment.topCenter,
                children: [

                  Padding(
                    padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.08),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            SizedBox(height: MediaQuery.of(context).size.height*.06,),
                            ReuseableRow(title: "Total Cases", value: widget.totalCases.toString()),
                            ReuseableRow(title: "Recovered", value: widget.totalRecovered.toString()),
                            ReuseableRow(title: "Deaths", value: widget.totalDeath.toString()),
                            ReuseableRow(title: "Active", value: widget.active.toString()),
                            ReuseableRow(title: "Tests", value: widget.tests.toString()),
                          ],
                        ),
                      ),
                    ),
                  ),
                  CircleAvatar(
                    radius: 55,
                    backgroundImage: NetworkImage(widget.image),
                  ),

                ],
              ),
            ],
          )),
    );
  }
}
