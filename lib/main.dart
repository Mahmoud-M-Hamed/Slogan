import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slogan/components/constants/constants.dart';
import 'package:slogan/moduels/slogan/home_activity/home_activity.dart';
import 'package:slogan/moduels/slogan/home_activity/home_statemangment/home_cubit.dart';
import 'package:slogan/moduels/slogan/home_activity/home_statemangment/home_states.dart';
import 'package:slogan/moduels/slogan/onboarding_activities/onboarding_activity.dart';
import 'package:slogan/shared_helper/dio_helper/dio.dart';
import 'package:slogan/shared_helper/sharedpreferences_helper/sharedpreferences.dart';
import 'package:slogan/shared_helper/statemanegment_bloc_observer/bloc_observer.dart';
import 'package:slogan/styles/themes.dart';
import 'moduels/slogan/signin_activity/signin_activity.dart';

void main() async {
  Widget? startWidget;

  WidgetsFlutterBinding.ensureInitialized();

  await DioHelper.init();
  await SharedPreferenceHelper.init();
  Bloc.observer = MyBlocObserver();

  Object? onBoardingSkip =
      SharedPreferenceHelper.getData(key: "onBoardingSkip");
  token = SharedPreferenceHelper.getData(key: "token");

  if (onBoardingSkip != null) {
    if (token != null) {
      startWidget = const SloganHomeActivity();
    } else {
      startWidget = SignInActivity();
    }
  } else {
    startWidget = const OnBoardingActivity();
  }

  runApp(SloganApp(
    startWidget: startWidget,
  ));
}

// ignore: must_be_immutable
class SloganApp extends StatelessWidget {
  Widget? startWidget;

  SloganApp({super.key, this.startWidget});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => HomeCubit()
        ..getHomeData()
        ..getCategoryData()
        ..getFavoritesData()
        ..getCartData(),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (ctx, state) {},
        builder: (ctx, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: "Slogan",
            home: SafeArea(child: startWidget!),
            theme: lightTheme,
          );
        },
      ),
    );
  }
}
