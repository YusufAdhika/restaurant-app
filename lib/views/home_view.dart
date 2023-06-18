import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_api/controllers/restaurant_controller.dart';
import 'package:restaurant_api/data/enum/result_state.dart';
import 'package:restaurant_api/widgets/blank_massage.dart';
import 'package:restaurant_api/widgets/list_restaurant.dart';
import 'package:restaurant_api/widgets/loading_custom.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final controller = Get.put(RestaurantController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Restaurant API",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [dropDown()],
        backgroundColor: Colors.grey[300],
        elevation: 0,
      ),
      body: Obx(() {
        switch (controller.resultState.value) {
          case ResultState.loading:
            return const CLoading();
          case ResultState.noData:
            return RefreshIndicator(
              color: Colors.grey,
              onRefresh: () async {
                controller.getRestaurant();
              },
              child: const BlankItemView(
                image: "assets/refresh.png",
                title: "No Restaurant Found",
                subtitle: "",
              ),
            );
          case ResultState.hasData:
            return RefreshIndicator(
              color: Colors.grey,
              onRefresh: () async {
                controller.getRestaurant();
              },
              child: ListView(
                children: [
                  ListRestaurant(
                    restaurant: controller.restaurantsList,
                  )
                ],
              ),
            );
          case ResultState.error:
            return BlankItemView(
                image: "assets/wifi.png",
                title: "Error Connection",
                subtitle: "Please Check your Internet",
                buttonText: "Retry",
                onTap: () => controller.getRestaurant());
          default:
            return const SizedBox();
        }
      }),
    );
  }

  Widget dropDown() {
    return PopupMenuButton<String>(
      onSelected: controller.handleMenuSelection,
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem<String>(
            value: 'search',
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.search,
                  size: 24,
                  color: Colors.black,
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  "Search",
                  style: Theme.of(context).textTheme.titleMedium,
                )
              ],
            ),
          ),
          PopupMenuItem<String>(
            value: 'favourite',
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.favorite,
                  size: 24,
                  color: Colors.black,
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  "Favourite",
                  style: Theme.of(context).textTheme.titleMedium,
                )
              ],
            ),
          ),
          PopupMenuItem<String>(
            value: 'setting',
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.settings,
                  size: 24,
                  color: Colors.black,
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  "Setting",
                  style: Theme.of(context).textTheme.titleMedium,
                )
              ],
            ),
          ),
        ];
      },
      icon: const Icon(
        Icons.more_vert,
        color: Colors.black,
      ),
    );
  }
}
