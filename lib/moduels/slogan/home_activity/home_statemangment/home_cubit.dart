import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:slogan/components/constants/constants.dart';
import 'package:slogan/models/home_models/cart_model/cart_model.dart';
import 'package:slogan/models/home_models/category_model/category_model.dart';
import 'package:slogan/models/home_models/favorites_model/favorites_model.dart';
import 'package:slogan/models/home_models/products_model/products_model.dart';
import 'package:slogan/models/home_models/profile_model/profile_model.dart';
import 'package:slogan/moduels/slogan/home_activity/home_statemangment/home_states.dart';
import 'package:slogan/moduels/slogan/slogan_moduels_activities/cart_activity/cart_activity.dart';
import 'package:slogan/moduels/slogan/slogan_moduels_activities/category_activity/categories_activity.dart';
import 'package:slogan/moduels/slogan/slogan_moduels_activities/favorites_activity/favorites_activity.dart';
import 'package:slogan/moduels/slogan/slogan_moduels_activities/products_activity/products_activity.dart';
import 'package:slogan/moduels/slogan/slogan_moduels_activities/profile_activity/profile_activity.dart';
import 'package:slogan/shared_helper/dio_helper/dio.dart';
import 'package:slogan/shared_helper/network/end_points.dart';
import '../../../../shared_helper/sharedpreferences_helper/sharedpreferences.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  final GlobalKey<SliderDrawerState> key = GlobalKey<SliderDrawerState>();

  HomeModel? homeModel;
  ProfileModel? profileModel;
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
    Icons.logout,
  ];

  List<String> sliderTitle = [
    "Products",
    "Category",
    "Favorites",
    "Cart",
    "Profile",
    "SignOut",
  ];

  List<Widget> bodyActivities = [
    const ProductsActivity(),
    const CategoriesActivity(),
    const FavoritesActivity(),
    const CartActivity(),
    const ProfileActivity(),
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

  Future<void> userSignOut() async {
    await SharedPreferenceHelper.removeData(key: 'token');
    await SharedPreferenceHelper.removeData(key: 'onBoardingSkip');
  }

  Future<void> getUserProfileData() async {
    emit(ProfileLoadingDataState());
    Object? token = SharedPreferenceHelper.getData(key: "token");
    await DioHelper.getData(url: profile, token: token).then((value) {
      profileModel = ProfileModel.fromJson(value.data);
      emit(ProfileGetDataSuccessState());
    }).catchError((e) {
      emit(ProfileGetDataErrorState());
    });
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

  Future<void> getFavoritesData() async {
    emit(FavoritesLoadingDataState());
    Object? token = SharedPreferenceHelper.getData(key: "token");
    await DioHelper.getData(url: favorites, token: token).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      emit(FavoritesGetDataSuccessState(favoritesModel!));
    }).catchError((e) {
      emit(FavoritesGetDataErrorState());
    });
  }

  Future<void> postFavoritesData(int? productId) async {
    emit(FavoritesLoadingDataState());
    inFavorite[productId] = !inFavorite[productId]!;
    emit(FavoritesChangeIconState());
    await DioHelper.postData(
      url: favorites,
      data: {'product_id': productId},
      token: token,
    ).then((value) {
      if (value.data['status'] == false) {
        inFavorite[productId] = !inFavorite[productId]!;
      } else {
        getFavoritesData();
      }
      emit(FavoritesPostDataSuccessState());
    }).catchError((e) {
      inFavorite[productId] = !inFavorite[productId]!;
      emit(FavoritesPostDataErrorState());
    });
  }

  Future<void> getCartData() async {
    emit(CartLoadingDataState());
    Object? token = SharedPreferenceHelper.getData(key: "token");
    await DioHelper.getData(url: carts, token: token).then((value) {
      cartModel = CartModel.fromJson(value.data);
      emit(CartGetDataSuccessState());
    }).catchError((e) {
      emit(CartGetDataErrorState());
    });
  }

  Future<void> postCartData(int? productId) async {
    emit(CartLoadingDataState());
    inCart[productId] = !inCart[productId]!;
    await DioHelper.postData(
      url: carts,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      if (value.data['status'] == false) {
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
