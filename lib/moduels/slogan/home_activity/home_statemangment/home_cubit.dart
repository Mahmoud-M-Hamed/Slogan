import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:slogan/components/constants/constants.dart';
import 'package:slogan/models/home_models/cart_model/cart_model.dart';
import 'package:slogan/models/home_models/category_model/category_model.dart';
import 'package:slogan/models/home_models/favorites_model/favorites_model.dart';
import 'package:slogan/models/home_models/products_model/products_model.dart';
import 'package:slogan/moduels/slogan/home_activity/home_statemangment/home_states.dart';
import 'package:slogan/moduels/slogan/slogan_moduels_activities/cart_activity/cart_activity.dart';
import 'package:slogan/moduels/slogan/slogan_moduels_activities/category_activity/categories_activity.dart';
import 'package:slogan/moduels/slogan/slogan_moduels_activities/favorites_activity/favorites_activity.dart';
import 'package:slogan/moduels/slogan/slogan_moduels_activities/products_activity/products_activity.dart';
import 'package:slogan/moduels/slogan/slogan_moduels_activities/profile_activity/profile_activity.dart';
import 'package:slogan/moduels/slogan/slogan_moduels_activities/settings_activity/settings_activity.dart';
import 'package:slogan/shared_helper/dio_helper/dio.dart';
import 'package:slogan/shared_helper/network/end_points.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  final GlobalKey<SliderDrawerState> key = GlobalKey<SliderDrawerState>();

  HomeModel? homeModel;
  FavoritesModel? favoritesModel;
  CategoryModel? categoryModel;
  CartModel? cartModel;

  Map<int?, bool?> inFavorite = {};
  Map<int?, bool?> inCart = {};

  int currentIndex = 0;

  IconData sliderLeadingIcon = Icons.keyboard_arrow_up;
  IconData changeFavoriteIcon = Icons.favorite_border;
  IconData changeAddToCartIcon = Icons.add_shopping_cart_rounded;

  Color changeFavoriteIconColor = Colors.blueGrey;
  Color changeAddToCartIconColor = Colors.blueGrey;

  List<IconData> sliderIcons = [
    Icons.new_label,
    Icons.apps,
    Icons.favorite,
    Icons.add_shopping_cart_rounded,
    Icons.person,
    Icons.settings,
  ];

  List<String> sliderTitle = [
    "Products",
    "Category",
    "Favorites",
    "Cart",
    "profile",
    "Settings",
  ];

  List<Widget> bodyActivities = [
    const ProductsActivity(),
    const CategoriesActivity(),
    const FavoritesActivity(),
    const CartActivity(),
    const ProfileActivity(),
    const SettingsActivity(),
  ];

  void changeCurrentIndexState({required int? index}) {
    currentIndex = index!;
    if (key.currentState!.isDrawerOpen == true) {
      key.currentState!.closeSlider();
      sliderLeadingIcon = Icons.keyboard_arrow_up;
      emit(HomeSliderCloseState());
    }
    emit(HomeCurrentIndexState());
  }

  void changeSliderOpenCloseState() {
    if (key.currentState!.isDrawerOpen) {
      sliderLeadingIcon = Icons.keyboard_arrow_up;
      key.currentState!.closeSlider();
      emit(HomeSliderCloseState());
    } else {
      sliderLeadingIcon = Icons.keyboard_arrow_down;
      key.currentState!.openSlider();
      emit(HomeSliderOpenState());
    }
  }

  void getHomeData() {
    emit(HomeLoadingDataState());
    DioHelper.getData(url: home, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      for (var element in homeModel!.data!.products) {
        inFavorite.addAll({
          element.id: element.inFavorite,
        });
        inCart.addAll({
          element.id: element.inCart,
        });
      }
      emit(HomeGetDataSuccessState());
    }).catchError((getDataError) {
      emit(HomeGetDataErrorState());
    });
  }

  void getCategoryData() {
    emit(CategoryLoadingDataState());
    DioHelper.getData(url: categories, token: token).then((value) {
      categoryModel = CategoryModel.fromJson(value.data);
      emit(CategoryGetDataSuccessState());
    }).catchError((getDataError) {
      emit(CategoryGetDataErrorState());
    });
  }

  void getFavoritesData() {
    emit(FavoritesLoadingDataState());
    DioHelper.getData(url: favorites, token: token).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      emit(FavoritesGetDataSuccessState(favoritesModel!));
    }).catchError((getFavoritesError) {
      emit(FavoritesGetDataErrorState());
    });
  }

  Future<void> postFavoritesData(int? productId) async {
    emit(FavoritesLoadingDataState());
    inFavorite[productId] = !inFavorite[productId]!;
    emit(FavoritesChangeIconState());
    await DioHelper.postData(
            url: favorites, data: {'product_id': productId}, token: token)
        .then((value) {
      if (favoritesModel!.status == false) {
        inFavorite[productId] = !inFavorite[productId]!;
      } else {
        getFavoritesData();
      }
      emit(FavoritesPostDataSuccessState());
    }).catchError((postFavoriteError) {
      inFavorite[productId] = !inFavorite[productId]!;
      emit(FavoritesPostDataErrorState());
    });
  }

  void getCartData() {
    emit(CartLoadingDataState());
    DioHelper.getData(url: carts, token: token).then((value) {
      cartModel = CartModel.fromJson(value.data);
      emit(CartGetDataSuccessState());
    }).catchError((e) {
      emit(CartGetDataErrorState());
    });
  }

  void postCartData(int? productId) {
    emit(CartLoadingDataState());
    inCart[productId] = !inCart[productId]!;
    DioHelper.postData(
            url: carts,
            data: {
              'product_id': productId,
            },
            token: token)
        .then((value) {
      if (cartModel!.status == false) {
        inCart[productId] = !inCart[productId]!;
      } else {
        getCartData();
      }
      emit(CartPostDataSuccessState());
    }).catchError((e) {
      inCart[productId] = !inCart[productId]!;
      emit(CartPostDataErrorState());
    });
  }
}
