import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:slogan/moduels/slogan/home_activity/home_statemangment/home_cubit.dart';
import 'package:slogan/moduels/slogan/home_activity/home_statemangment/home_states.dart';
import 'package:slogan/moduels/slogan/onboarding_activities/onboarding_activity.dart';
import 'package:slogan/styles/colors.dart';

class SloganHomeActivity extends StatefulWidget {
  const SloganHomeActivity({super.key});

  @override
  State<SloganHomeActivity> createState() => _SloganHomeActivityState();
}

class _SloganHomeActivityState extends State<SloganHomeActivity> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (ctx, state) {},
      builder: (ctx, state) {
        HomeCubit homeCubit = HomeCubit.get(context);

        return SafeArea(
          child: Scaffold(
            body: SliderDrawer(
              key: homeCubit.key,
              slideDirection: SlideDirection.TOP_TO_BOTTOM,
              sliderOpenSize: 160,
              animationDuration: 900,
              appBar: SliderAppBar(
                appBarHeight: 50,
                appBarPadding: const EdgeInsets.only(top: 0),
                title: const Text(
                  "Slogan",
                  style: TextStyle(
                    color: mainColor,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    fontSize: 22,
                  ),
                ),
                drawerIcon: IconButton(
                    onPressed: () {
                      homeCubit.changeSliderOpenCloseState();
                    },
                    icon: Icon(
                      homeCubit.sliderLeadingIcon,
                      size: 30,
                    )),
              ),
              slider: Container(
                height: 160,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      mainColor,
                      melloGradientColor,
                    ],
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              backgroundColor: Colors.black,
                              radius: 45,
                              backgroundImage: NetworkImage(
                                  "https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/a06f48130839595.618928f013249.png"),
                            ),
                          ),
                          Text(
                              (homeCubit.profileModel == null)
                                  ? 'Akaza'.toUpperCase()
                                  : homeCubit.profileModel!.data!.name.toString().toUpperCase(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: Colors.white.withOpacity(0.8)),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          Flexible(
                            fit: FlexFit.loose,
                            child: GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 3,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 5,
                                ),
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                padding: const EdgeInsets.all(15),
                                itemCount: homeCubit.sliderIcons.length,
                                itemBuilder: (ctx, index) => Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: InkWell(
                                        onTap: () async {
                                          if (index == 5) {
                                            await homeCubit
                                                .userSignOut()
                                                .whenComplete(
                                                  () => Navigator.of(context)
                                                      .pushReplacement(
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          const OnBoardingActivity(),
                                                    ),
                                                  ),
                                                );
                                          }else{
                                            homeCubit.changeCurrentIndexState(
                                              index: index,
                                            );
                                          }
                                        },
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          textBaseline: TextBaseline.alphabetic,
                                          children: [
                                            Icon(
                                              homeCubit.sliderIcons[index],
                                              color: Colors.white38,
                                              size: 20,
                                            ),
                                            const SizedBox(
                                              width: 3,
                                            ),
                                            Expanded(
                                              child: Text(
                                                homeCubit.sliderTitle[index],
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  color: Colors.white38,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              child: homeCubit.bodyActivities[homeCubit.currentIndex],
            ),
          ),
        );
      },
    );
  }
}
