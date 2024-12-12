import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leaflet_app/controller/home_screen_controller/home_screen_controller.dart';
import 'package:leaflet_app/utils/color_constants.dart';
import 'package:leaflet_app/view/global_widget/custom_app_bar.dart';
import 'package:leaflet_app/view/sub_category_screen/sub_category_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});
  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late ScrollController scrollController;
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('homeScreenCategory').snapshots();
  final Stream<QuerySnapshot> _usersStream1 =
      FirebaseFirestore.instance.collection('carouselSliderImages').snapshots();

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    super.dispose();
  }

  _onScroll() {
    final offset = scrollController.offset;
    ref.read(homeScreenNotifierProvider.notifier).update(offset);
    //print('Offset: $offset, State: ${ref.read(HomeScreenNotifierProvider)}');
  }

  @override
  Widget build(BuildContext context) {
    //final animationState = ref.watch(HomeScreenNotifierProvider);
    return Scaffold(
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          CustomAppBar(),
          SliverToBoxAdapter(
            child: StreamBuilder(
              stream: (_usersStream),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final homeScreenmaincategoryList = snapshot.data!.docs;

                  return ListView.separated(
                    shrinkWrap: true, // Ensure it wraps the content
                    physics:
                        const NeverScrollableScrollPhysics(), // Disable internal scroll
                    itemBuilder: (context, index) {
                      final plant = homeScreenmaincategoryList[index];
                      final plantId = plant.id;
                      return InkWell(
                        onTap: () {},
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              height: 200,
                              margin: const EdgeInsets.symmetric(
                                horizontal: 40,
                                vertical: 10,
                              ),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                    homeScreenmaincategoryList[index]["image"],
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Consumer(
                              builder: (context, ref, child) {
                                final animationState =
                                    ref.watch(homeScreenNotifierProvider);
                                return AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                  height: animationState.height,
                                  width: MediaQuery.of(context).size.width *
                                      animationState.width,
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 30,
                                    vertical: 10,
                                  ),
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: Colors.white, width: 3),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 10,
                                        offset: Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        homeScreenmaincategoryList[index]
                                                ["name"]
                                            .toString(),
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      SubCategoryScreen(
                                                          id: plantId,
                                                          title:
                                                              homeScreenmaincategoryList[
                                                                      index]
                                                                  ["name"])));
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 20,
                                            vertical: 10,
                                          ),
                                        ),
                                        child: const Text(
                                          "Shop",
                                          style: TextStyle(
                                            color: Colors.green,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    },
                    itemCount: snapshot.data!.docs.length,
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 10,
                    ),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return const Center(
                    child: Text("Something went wrong"),
                  );
                }
                return const SizedBox();
              },
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "BESTSELLERS",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        6,
                        (index) => Padding(
                          padding: EdgeInsets.all(8),
                          child: Container(
                            height: 200,
                            width: 200,
                            color: Colors.pink,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: StreamBuilder(
              stream: _usersStream1,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return const Center(
                    child: Text("Something went wrong"),
                  );
                }
                if (snapshot.hasData) {
                  final carouselSliderImagesList = snapshot.data!.docs;
                  return SizedBox(
                    height: 350,
                    child: CarouselSlider(
                      options: CarouselOptions(
                        height: 350,
                        aspectRatio: 16 / 9,
                        viewportFraction: 0.8,
                        enableInfiniteScroll: true,
                        autoPlay: false,
                        autoPlayInterval: const Duration(seconds: 3),
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 300),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        enlargeFactor: 0.3,
                      ),
                      items: List.generate(carouselSliderImagesList.length,
                          (index) {
                        return Container(
                          child: Column(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 300,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          carouselSliderImagesList[index]
                                              ["image"]),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Center(
                                    child: Container(
                                      color: ColorConstants.mainwhite,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Text(
                                        carouselSliderImagesList[index]
                                            ["caption"],
                                        style: TextStyle(
                                          color: ColorConstants.primaryColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 22,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  );
                }
                return SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}
