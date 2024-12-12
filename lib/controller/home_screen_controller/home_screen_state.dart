class HomeScreenState {
  final double height;
  final double width;
  int currentindex;
  HomeScreenState(
      {required this.height, required this.width, required this.currentindex});
  HomeScreenState copywith({double? height, double? width, int? currentIndex}) {
    return HomeScreenState(
        height: height ?? this.height,
        width: width ?? this.width,
        currentindex: currentIndex ?? this.currentindex);
  }
}
