import 'package:slogan/models/home_models/cart_model/cart_model.dart';
import 'package:slogan/models/home_models/favorites_model/favorites_model.dart';

abstract class HomeStates {}

class HomeInitialState extends HomeStates {}

class HomeCurrentIndexState extends HomeStates {}

class HomeSliderOpenState extends HomeStates {}

class HomeSliderCloseState extends HomeStates {}

class HomeLoadingDataState extends HomeStates {}

class HomeGetDataSuccessState extends HomeStates {}

class HomeGetDataErrorState extends HomeStates {}

class CategoryLoadingDataState extends HomeStates {}

class CategoryGetDataSuccessState extends HomeStates {}

class CategoryGetDataErrorState extends HomeStates {}

class FavoritesLoadingDataState extends HomeStates {}

class FavoritesGetDataSuccessState extends HomeStates {
  final FavoritesModel favoritesModel;

  FavoritesGetDataSuccessState(this.favoritesModel);
}

class FavoritesGetDataErrorState extends HomeStates {}

class FavoritesPostDataSuccessState extends HomeStates {}

class FavoritesPostDataErrorState extends HomeStates {}

class FavoritesChangeIconState extends HomeStates {}

class CartLoadingDataState extends HomeStates {}

class CartGetDataSuccessState extends HomeStates {}

class CartGetDataErrorState extends HomeStates {}

class CartPostDataSuccessState extends HomeStates {}

class CartPostDataErrorState extends HomeStates {}

class CartChangeIconState extends HomeStates {}
