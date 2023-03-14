import 'package:flutter/material.dart';
import 'package:slider_button/slider_button.dart';
import 'package:slogan/models/onboarding_model/onboarding_model.dart';
import 'package:slogan/shared_helper/sharedpreferences_helper/sharedpreferences.dart';
import 'package:slogan/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../signin_activity/signin_activity.dart';

class OnBoardingActivity extends StatefulWidget {
  const OnBoardingActivity({super.key});

  @override
  State<OnBoardingActivity> createState() => _OnBoardingActivityState();
}

class _OnBoardingActivityState extends State<OnBoardingActivity> {
  PageController onBoardingController = PageController();

  OnBoardingModel onBoardingModel = OnBoardingModel();

  bool isLastPage = false;

  Widget buildOnBoardingItem(OnBoardingModel onBoardingModel) => Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: Center(
              child: Image.asset(
                "${onBoardingModel.image}",
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            "${onBoardingModel.title}",
            style: const TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold, color: mainColor),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "${onBoardingModel.bodyTitle}",
          ),
          Text(
            "${onBoardingModel.bodySubTitle}",
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsetsDirectional.only(end: 10),
            child: Row(
              children: [
                const Text(
                  "NEXT",
                  style: TextStyle(color: Colors.indigo),
                ),
                IconButton(
                    onPressed: () {
                      (isLastPage)
                          ? SharedPreferenceHelper.saveData(
                                  key: "onBoardingSkip", value: true)
                              .then((value) {
                              if (value == true) {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            SignInActivity()));
                              }
                            })
                          : onBoardingController.nextPage(
                              duration: const Duration(milliseconds: 800),
                              curve: Curves.easeIn);
                    },
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.indigo,
                    )),
              ],
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                itemBuilder: (context, index) =>
                    buildOnBoardingItem(onBoardingModel.onboardingModel[index]),
                physics: const BouncingScrollPhysics(),
                itemCount: onBoardingModel.onboardingModel.length,
                controller: onBoardingController,
                onPageChanged: (int index) {
                  setState(() {
                    if (index == onBoardingModel.onboardingModel.length - 1) {
                      isLastPage = true;
                    } else {
                      isLastPage = false;
                    }
                  });
                },
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            SmoothPageIndicator(
              controller: onBoardingController,
              count: onBoardingModel.onboardingModel.length,
              effect: const ExpandingDotsEffect(
                activeDotColor: Colors.indigo,
                dotHeight: 5,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SliderButton(
              action: () {
                SharedPreferenceHelper.saveData(
                        key: "onBoardingSkip", value: true)
                    .then((value) {
                  if (value == true) {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => SignInActivity()));
                  }
                });
              },
              label: const Text("Slide To Skip"),
              height: 60,
              buttonColor: Colors.indigo,
              icon: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              ),
              width: 180,
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
