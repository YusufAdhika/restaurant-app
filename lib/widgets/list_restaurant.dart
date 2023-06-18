import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_api/controllers/restaurant_controller.dart';
import 'package:restaurant_api/data/models/restaurant_model.dart';
import 'package:restaurant_api/widgets/card_restaurant.dart';

class ListRestaurant extends StatelessWidget {
  ListRestaurant({required this.restaurant, super.key});

  final List<RestaurantModel> restaurant;
  final controller = Get.put(RestaurantController());  

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: restaurant.length,
      padding: const EdgeInsets.only(bottom: 18),
      itemBuilder: (context, index) {
        var data = restaurant[index];        
        return CardRestaurant(
          restaurant: data,
        );
      },
    );
  }
}
