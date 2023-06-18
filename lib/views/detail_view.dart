import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_api/controllers/restaurant_controller.dart';
import 'package:restaurant_api/data/enum/result_state.dart';
import 'package:restaurant_api/data/models/detail_restaurant_model.dart';
import 'package:restaurant_api/widgets/blank_massage.dart';
import 'package:restaurant_api/widgets/detail_restaurant.dart';
import 'package:restaurant_api/widgets/loading_custom.dart';

class DetailView extends StatelessWidget {
  DetailView({required this.restaurant, super.key});

  final DetailRestaurantModel restaurant;
  final controller = Get.put(RestaurantController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Detail Restaurant",
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.15,
          ),
        ),
        backgroundColor: Colors.grey,
        elevation: 0,
      ),
      body: Obx(
        () {
          switch (controller.detailState.value) {
            case ResultState.loading:
              return const CLoading();
            case ResultState.noData:
              return const BlankItemView(
                image: "assets/refresh.png",
                title: "No Restaurant Detail",
                subtitle: "",
              );
            case ResultState.hasData:
              return DetailRestaurant(
                restaurant: restaurant,
              );
            case ResultState.error:
              return const BlankItemView(
                image: "assets/wifi.png",
                title: "Error Connection",
                subtitle: "Please Check your Internet",
              );
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
