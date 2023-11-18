import 'dart:async';
import 'dart:math' as math;

import 'package:covid_tracker_app/View/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>with TickerProviderStateMixin {

  late final AnimationController _controller = AnimationController(
    duration: Duration(seconds: 3),
      vsync: this)..repeat();

  @override
  void dispose() {
    _controller.dispose(); // Call the dispose method of the AnimationController.
    super.dispose();
  }

  @override
 void initState(){
    super.initState();
   Timer(Duration(seconds: 3), () {
     Navigator.pushReplacement(context, MaterialPageRoute(builder: (contex)=>HomePage(),));
   });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedBuilder(
                animation: _controller,
                builder: (BuildContext context, Widget? child){
                  return Transform.rotate(
                      angle: _controller.value*2.0 * math.pi,
                    child: Center(
                      child: Container(
                        height: MediaQuery.of(context).size.height*0.30,
                        width: MediaQuery.of(context).size.height*0.30,
                        child: Image.asset("assets/images/virus.png"),
                        
                      ),
                    ),
                  
                  );
                  
                }),
            SizedBox(height: MediaQuery.of(context).size.height* .05,),
            Align(
              alignment: Alignment.center,
                child: Text("Covid-19 Tracker App", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),))
          ],
        ),
      ),
    );
  }
}
