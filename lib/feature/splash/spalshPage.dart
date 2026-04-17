import 'dart:async';

import 'package:e_commarcae/core/theme/appColors/app_color_light.dart';
import 'package:e_commarcae/core/utils/extension.dart';
import 'package:e_commarcae/feature/splash/welcomepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? timer;

  @override
  void initState() {
    
    super.initState();
    timer = Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Welcomepage()),
      );
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: context.wp(0.8),
              height: context.hp(0.31),
              
              child: Image.asset(
                "assets/images/splashImg.png",
                fit: BoxFit.cover,
              ),
            ),
            SpinKitFadingCircle(
              itemBuilder: (BuildContext context, int index) {
                return DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,

                    color: AppColorLight.cardBackground,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
