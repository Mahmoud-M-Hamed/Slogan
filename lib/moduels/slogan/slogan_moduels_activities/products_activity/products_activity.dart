import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slogan/components/constants/constants.dart';
import 'package:slogan/models/home_models/category_model/category_model.dart';
import 'package:slogan/models/home_models/products_model/products_model.dart';
import 'package:slogan/moduels/slogan/home_activity/home_statemangment/home_cubit.dart';
import 'package:slogan/moduels/slogan/home_activity/home_statemangment/home_states.dart';

class ProductsActivity extends StatelessWidget {
  const ProductsActivity({super.key});

  Widget productsItemBuilder(String? image) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
            image: NetworkImage(image!),
            fit: BoxFit.cover,
          ),
        ),
      );

  Widget productsBuilder(
          {required context,
          required HomeModel? productModel,
          required CategoryModel? categoryModel}) =>
      SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            CarouselSlider(
              items: productModel?.data?.banners.map((e) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  child: productsItemBuilder(e.image),
                );
              }).toList(),
              options: CarouselOptions(
                height: 180,
                autoPlay: true,
                scrollPhysics: const NeverScrollableScrollPhysics(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Categories".toUpperCase(),
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 100,
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        separatorBuilder: (ctx, index) => const SizedBox(
                              width: 8,
                            ),
                        itemBuilder: (ctx, index) => Stack(
                              children: [
                                Container(
                                  height: 90,
                                  width: 90,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        categoryModel
                                            .data!.categoryData![index].image
                                            .toString(),
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  height: 90,
                                  width: 90,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.black.withOpacity(0.5),
                                  ),
                                  child: Text(
                                    categoryModel
                                        .data!.categoryData![index].name
                                        .toString(),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                        itemCount: categoryModel!.data!.categoryData!.length),
                  ),
                  Text(
                    "New Products".toUpperCase(),
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            gridItemsBuilder(context, productModel),
          ],
        ),
      );

  Widget gridItemsBuilder(context, HomeModel? productModel) => GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 0.1,
        crossAxisSpacing: 0.1,
        childAspectRatio: 1 / 1.4,
        padding: const EdgeInsets.all(8),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: productModel!.data!.products
            .map((e) => generateItemBuilder(
                productModel: productModel,
                context: context,
                eImage: e.image,
                eName: e.name,
                ePrice: e.price,
                eOldPrice: e.oldPrice,
                eId: e.id))
            .toList(),
      );

  Widget generateItemBuilder({
    required HomeModel? productModel,
    required context,
    required String? eImage,
    required String? eName,
    required dynamic ePrice,
    required dynamic eOldPrice,
    required int? eId,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Center(
                child: Image(
                  image: NetworkImage(eImage!),
                  height: 120,
                ),
              ),
              if (eOldPrice != null)
                Container(
                  color: Colors.red,
                  padding: const EdgeInsets.all(3),
                  child: Text(
                    "discount".toUpperCase(),
                    style: const TextStyle(fontSize: 8, color: Colors.white),
                  ),
                ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            eName!,
            style: Theme.of(context).textTheme.bodyLarge,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "${ePrice.toString()} L.E",
                style: const TextStyle(
                    color: Colors.lightGreen,
                    fontSize: 13,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                width: 10,
              ),
              if (eOldPrice != null)
                Text(
                  eOldPrice.toString(),
                  style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 11,
                      decoration: TextDecoration.lineThrough),
                ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () {
                    HomeCubit.get(context).postCartData(eId);
                  },
                  icon: Icon(
                    (HomeCubit.get(context).inCart[eId] == true)
                        ? Icons.shopping_cart
                        : Icons.add_shopping_cart,
                    color: (HomeCubit.get(context).inCart[eId] == true)
                        ? Colors.indigo
                        : Colors.blueGrey,
                    size: 18,
                  )),
              IconButton(
                  onPressed: () async {
                    await HomeCubit.get(context).postFavoritesData(eId);
                  },
                  icon: Icon(
                    (HomeCubit.get(context).inFavorite[eId] == true)
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: (HomeCubit.get(context).inFavorite[eId] == true)
                        ? Colors.redAccent
                        : Colors.blueGrey,
                    size: 18,
                  )),
            ],
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (ctx, state) {
        if (state is FavoritesGetDataSuccessState) {
          if (state.favoritesModel.status == false) {
            showToast(
                message: 'Error While Loading Data, Please Try Again Later...',
                toastStates: ToastStates.ERROR);
          }
        }
      },
      builder: (ctx, state) {
        HomeCubit productCubit = HomeCubit.get(context);

        return (productCubit.homeModel != null)
            ? productsBuilder(
                context: context,
                productModel: productCubit.homeModel,
                categoryModel: productCubit.categoryModel)
            : const Center(child: CircularProgressIndicator());
      },
    );
  }
}
