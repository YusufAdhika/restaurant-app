import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_api/controllers/favourite_controller.dart';
import 'package:restaurant_api/data/enum/result_state.dart';
import 'package:restaurant_api/widgets/blank_massage.dart';
import 'package:restaurant_api/widgets/card_favourite.dart';
import 'package:restaurant_api/widgets/loading_custom.dart';

class FavouriteView extends StatelessWidget {
  FavouriteView({super.key});

  final controller = Get.put(FavouriteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Favourite",
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.15,
          ),
        ),
      backgroundColor: Colors.grey,
        elevation: 0,
      ),
      body: ListView(
        children: [
          Obx(() {
            switch (controller.favouriteState.value) {
              case ResultState.loading:
                return const CLoading();
              case ResultState.noData:
                return const BlankItemView(
                  image: "assets/favourite.png",
                  title: "No Restaurant Found",
                  subtitle: "Add Restaurant to Favourite",
                );
              case ResultState.hasData:
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.listFav.length,
                  padding: const EdgeInsets.only(bottom: 18),
                  itemBuilder: (context, index) {
                    var data = controller.listFav[index];
                    return CardFavourite(restaurant: data);
                  },
                );

              case ResultState.error:
                return const BlankItemView(
                  title: "Error Connection",
                  subtitle: "Please Check your Internet",
                );
              default:
                return const SizedBox();
            }
          })
        ],
      ),
    );
  }
}
