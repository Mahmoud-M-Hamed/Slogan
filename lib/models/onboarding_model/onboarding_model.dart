class OnBoardingModel {
  String? image, title, bodyTitle, bodySubTitle;

  OnBoardingModel({this.image, this.title, this.bodyTitle, this.bodySubTitle});

  List<OnBoardingModel> get onboardingModel {
    return [
      OnBoardingModel(
          image: "assets/images/OIP_3.jpg",
          title: "Easy Shopping",
          bodyTitle: "Like A B C, goods and commodities",
          bodySubTitle: " brought to your fingertips."),
      OnBoardingModel(
          image: "assets/images/OIP_2.jpg",
          title: "Abundant Shopping",
          bodyTitle: "A wide collection of over 200,000 items",
          bodySubTitle: " from top brands all over the world."),
      OnBoardingModel(
          image: "assets/images/onboard_1.jpg",
          title: "Amazing Discounts",
          bodyTitle: "Cheaper prices than your local store,",
          bodySubTitle: " great discounts and cashback offers."),
    ];
  }
}
