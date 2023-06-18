import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_api/controllers/restaurant_controller.dart';
import 'package:restaurant_api/data/enum/result_state.dart';
import 'package:restaurant_api/widgets/blank_massage.dart';
import 'package:restaurant_api/widgets/list_restaurant.dart';
import 'package:restaurant_api/widgets/loading_custom.dart';

class SearchView extends StatelessWidget {
  SearchView({super.key});

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
      body: ListView(
        children: [
          searchBox(),
          Obx(() {
            switch (controller.searchState.value) {
              case ResultState.loading:
                return const CLoading();
              case ResultState.noData:
                return const BlankItemView(
                  // image: "assets/sad.png",
                  lottie: "assets/lottie/ghost_empty.json",
                  title: "No Restaurant Found",
                  subtitle: "Please enter search query",
                );
              case ResultState.hasData:
                return ListRestaurant(
                  restaurant: controller.searchList,
                );
              case ResultState.error:
                return BlankItemView(
                    image: "assets/wifi.png",
                    title: "Error Connection",
                    subtitle: "Please Check your Internet",
                    buttonText: "Retry",
                    onTap: () => controller.getSearch(
                          controller.searchText.value,
                        ));
              default:
                return const SizedBox();
            }
          })
        ],
      ),
    );
  }

  Widget searchBox() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 18,
        right: 18,
        top: 18,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.04),
                  borderRadius: BorderRadius.circular(12)),
              child: TextField(
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(
                    left: 18,
                    right: 18,
                    top: 16,
                    bottom: 16,
                  ),
                  hintText: "Search",
                  border: InputBorder.none,
                ),
                style: const TextStyle(
                  fontSize: 14,
                ),
                onChanged: (text) {
                  controller.searchText.value = text;
                },
              ),
            ),
          ),
          const SizedBox(
            width: 9,
          ),
          Expanded(
            flex: 1,
            child: Container(
              width: 45,
              height: 45,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(12)),
              child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    controller.getSearch(
                      controller.searchText.value,
                    );
                  },
                  hoverColor: Colors.black,
                  child: const Icon(
                    Icons.search_rounded,
                  )),
            ),
          )
        ],
      ),
    );
  }
}
