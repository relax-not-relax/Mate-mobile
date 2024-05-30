import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mate_project/screens/introduction/onboard_screen.dart';
import 'package:mate_project/widgets/circular_progress.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  double _width = 0;
  double _height = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(
        seconds: 1,
      ),
      () {
        setState(() {
          _width = 148.03;
          _height = 212;
        });
      },
    );

    //This method is used to switch to onboard screen. Can be replaced in future with new method
    Future.delayed(
      const Duration(
        seconds: 4,
      ),
      () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const OnboardScreen(index: 0);
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 41, 45, 50),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Center(
              child: AnimatedContainer(
                duration: const Duration(seconds: 1),
                curve: Curves.easeInExpo,
                width: _width.w,
                height: _height.h,
                child: Image.asset(
                  'assets/pics/app_logo.png',
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  SizedBox(
                    width: 60.w,
                    height: 60.h,
                    child: const CircularProgressCustom(
                      beginColor: Color.fromARGB(255, 131, 189, 255),
                      endColor: Color.fromARGB(255, 95, 85, 242),
                      backgroundColorSelection:
                          const Color.fromARGB(255, 41, 45, 50),
                    ),
                  ),
                  SizedBox(
                    height: 70.h,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
