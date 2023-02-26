import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slogan/models/home_models/products_model/products_model.dart';
import 'package:slogan/moduels/slogan/home_activity/home_statemangment/home_cubit.dart';
import 'package:slogan/moduels/slogan/home_activity/home_statemangment/home_states.dart';

class FavoritesActivity extends StatelessWidget {
  const FavoritesActivity({super.key});

  Widget generateItemBuilder({
    required HomeModel? productModel,
    required context,
    required String? eImage,
    required String? eName,
    required dynamic ePrice,
    required dynamic eOldPrice,
    required int? eId,
  }) =>
      Row(
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Center(
                child: Image(
                  image: NetworkImage(eImage!),
                  height: 120,
                  width: 100,
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
            height: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  eName!,
                  style: Theme.of(context).textTheme.bodyLarge,
                  maxLines: 1,
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
                        onPressed: () {
                          HomeCubit.get(context).postFavoritesData(eId);
                        },
                        icon: Icon(
                          (HomeCubit.get(context).inFavorite[eId] == true)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color:
                              (HomeCubit.get(context).inFavorite[eId] == true)
                                  ? Colors.redAccent
                                  : Colors.blueGrey,
                          size: 18,
                        )),
                  ],
                ),
              ],
            ),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (ctx, state) {},
      builder: (ctx, state) {
        HomeCubit favoriteCubit = HomeCubit.get(context);
        return (state is FavoritesLoadingDataState)
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemCount: favoriteCubit.favoritesModel!.data!.data.length,
                separatorBuilder: (ctx, index) => const Divider(
                  color: Colors.blueGrey,
                  indent: 20,
                  endIndent: 20,
                  thickness: 0.5,
                ),
                itemBuilder: (ctx, index) => Container(
                  height: 100,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: generateItemBuilder(
                    productModel: favoriteCubit.homeModel,
                    context: context,
                    eId: favoriteCubit
                        .favoritesModel!.data!.data[index].product!.id,
                    eName: favoriteCubit
                        .favoritesModel!.data!.data[index].product!.name,
                    eImage: favoriteCubit
                        .favoritesModel!.data!.data[index].product!.image,
                    eOldPrice: favoriteCubit
                        .favoritesModel!.data!.data[index].product!.oldPrice,
                    ePrice: favoriteCubit
                        .favoritesModel!.data!.data[index].product!.price,
                  ),
                ),
              );
      },
    );
  }
}
