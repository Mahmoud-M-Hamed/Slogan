import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slogan/models/home_models/category_model/category_model.dart';
import 'package:slogan/moduels/slogan/home_activity/home_statemangment/home_cubit.dart';
import 'package:slogan/moduels/slogan/home_activity/home_statemangment/home_states.dart';

class CategoriesActivity extends StatelessWidget {
  const CategoriesActivity({super.key});

  Widget categoryItemBuilder({@required CategoryModel? categoryModel}) =>
      ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemCount: categoryModel!.data!.categoryData!.length,
        separatorBuilder: (ctx, index) => const Divider(
            color: Colors.grey, endIndent: 20, indent: 20, thickness: 0.5),
        itemBuilder: (ctx, index) =>
            categoryListItemBuilder(categoryModel: categoryModel, index: index),
      );

  Widget categoryListItemBuilder(
          {@required CategoryModel? categoryModel, @required int? index}) =>
      Container(
        height: 100,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Row(
          children: [
            Stack(
              children: [
                Container(
                  height: 100,
                  width: 90,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                          image: NetworkImage(categoryModel!
                              .data!.categoryData![index!].image
                              .toString()),
                          fit: BoxFit.cover)),
                ),
                Container(
                  height: 100,
                  width: 90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.black.withOpacity(0.1),
                  ),
                )
              ],
            ),
            const SizedBox(
              width: 15,
            ),
            Text(
              categoryModel.data!.categoryData![index].name.toString(),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const Spacer(),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  size: 30,
                ))
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (ctx, state) {},
      builder: (ctx, state) {
        HomeCubit categoryCubit = HomeCubit.get(context);
        return categoryItemBuilder(categoryModel: categoryCubit.categoryModel);
      },
    );
  }
}
