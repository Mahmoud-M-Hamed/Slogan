import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slogan/components/reusable_components/reusable_components.dart';
import 'package:slogan/moduels/slogan/home_activity/home_statemangment/home_cubit.dart';
import 'package:slogan/moduels/slogan/home_activity/home_statemangment/home_states.dart';

import '../../../../styles/colors.dart';

class ProfileActivity extends StatelessWidget {
  const ProfileActivity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        HomeCubit homeCubit = HomeCubit.get(context);

        List<IconData> iconList = [
          Icons.person,
          Icons.email_rounded,
          Icons.phone,
          Icons.favorite,
          Icons.add_shopping_cart,
        ];

        List dataList = [
          homeCubit.profileModel!.data!.name,
          homeCubit.profileModel!.data!.email,
          homeCubit.profileModel!.data!.phone,
          homeCubit.favoritesModel!.data!.data.length,
          homeCubit.cartModel!.data!.cartItems.length,
        ];

        return Stack(
          alignment: Alignment.topCenter,
          children: [
            Column(
              children: [
                30.ph,
                Stack(
                  alignment: Alignment.bottomRight,
                  children: const [
                    CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: 70,
                      backgroundImage: NetworkImage(
                        "https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/a06f48130839595.618928f013249.png",
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.indigo,
                      child: Icon(Icons.camera_alt),
                    ),
                  ],
                ),
                50.ph,
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      //color: Colors.indigo,
                      gradient: LinearGradient(
                        colors: [
                          mainColor,
                          melloGradientColor,
                        ],
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      children: List.generate(
                        iconList.length,
                        (index) => Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  20.pw,
                                  Icon(
                                    iconList[index],
                                    color: Colors.white60,
                                  ),
                                  3.pw,
                                  Text(
                                    ':  ${dataList[index]}'.toUpperCase(),
                                    style: const TextStyle(
                                      color: Colors.white60,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              (index == iconList.length - 1)
                                  ? Container()
                                  : const Divider(
                                      color: Colors.white60,
                                      indent: 10,
                                      endIndent: 10,
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
