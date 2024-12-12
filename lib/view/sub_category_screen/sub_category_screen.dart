import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leaflet_app/utils/color_constants.dart';
import 'package:leaflet_app/view/global_widget/custom_app_bar.dart';

class SubCategoryScreen extends ConsumerWidget {
  const SubCategoryScreen({required this.title, required this.id, super.key});
  final String id;
  final String title;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
        .collection('homeScreenCategory') // Parent collection
        .doc(id) // Parent document ID
        .collection('listOfPlants') // Nested collection
        .snapshots();
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              height: 10,
            ),
          ),
          SliverToBoxAdapter(
            child: StreamBuilder(
                stream: _usersStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return GridView.builder(
                      shrinkWrap: true, // Ensure it wraps the content
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 1 / 1.5,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5,
                        crossAxisCount: 2,
                      ),
                      itemBuilder: (context, index) {
                        final listofplants = snapshot.data!.docs;
                        // print(listofplants);
                        final plant = listofplants[index];

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Container(
                            height: 350,
                            width: 120,
                            color: ColorConstants.primaryColor.withOpacity(.2),
                            //  decoration: BoxDecoration(border: Border.all(width: 1)),
                            padding: EdgeInsets.all(5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  height: 180,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(plant["image"]),
                                          fit: BoxFit.cover)),
                                ),
                                Text(plant["name"]),
                                Text("₹${plant["price"].toString()}"),
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: WidgetStatePropertyAll(
                                      ColorConstants.primaryColor,
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: Text(
                                    "Add to cart",
                                    style: TextStyle(
                                        color: ColorConstants.mainwhite),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: snapshot.data!.docs.length,
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text("Something went wrong"));
                  }
                  return SizedBox();
                }),
          )
        ],
      ),
    );
  }
}
