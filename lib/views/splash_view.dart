import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_api/routes/routes_name.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  int splashtime = 3;
  @override
  void initState() {
    Future.delayed(Duration(seconds: splashtime), () async {
      Get.offAllNamed(RoutesName.homeView);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/dicoding.png",
                  scale: 5,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
