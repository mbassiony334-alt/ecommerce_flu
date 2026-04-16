import 'package:e_commarcae/core/utils/extension.dart';
import 'package:e_commarcae/core/widget/custom_elvated.dart';
import 'package:e_commarcae/feature/auth/view/logain.dart';
import 'package:e_commarcae/feature/splash/model/welcomeModel.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Welcomepage extends StatefulWidget {
  const Welcomepage({super.key});

  @override
  State<Welcomepage> createState() => _WelcomepageState();
}

class _WelcomepageState extends State<Welcomepage> {
  PageController controller = PageController();
  int currentIndex = 0;

  void change() {
    if (currentIndex < pages.length - 1) {
      controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(context.wp(0.04)),
        child: Column(
          children: [
           
            Expanded(
              child: PageView.builder(
                controller: controller,
                itemCount: pages.length,
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(pages[index].img),

                      SizedBox(height: context.hp(0.02)),

                      Text(
                        pages[index].tittle,
                        style: TextStyle(
                          fontSize: context.responsiveValue(
                            mobile: 18,
                            tablet: 22,
                            desktop: 26,
                          ),
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: context.hp(0.01)),

                      SizedBox(
                        width: context.wp(0.8),
                        child: Text(
                          pages[index].description,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

          
            SmoothPageIndicator(
              controller: controller,
              count: pages.length,
              effect: WormEffect(
                dotHeight: 10,
                dotWidth: 10,
                activeDotColor: Colors.blue,
              ),
            ),

            SizedBox(height: context.hp(0.03)),

            CustomElvated(
              buttonTitle: currentIndex == pages.length - 1
                  ? "Get Started"
                  : "Next",
              action: change,
              textwanted: true,
            ),
          ],
        ),
      ),
    );
  }
}
