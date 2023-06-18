import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_api/controllers/favourite_controller.dart';
import 'package:restaurant_api/controllers/restaurant_controller.dart';
import 'package:restaurant_api/data/models/cart_db.dart';
import 'package:restaurant_api/data/models/detail_restaurant_model.dart';

class LoveIcon extends StatelessWidget {
  LoveIcon({super.key, required this.restaurant});

  final DetailRestaurantModel restaurant;
  final controller = Get.put(FavouriteController());
  final controllerRestaurant = Get.put(RestaurantController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Positioned(
        bottom: 16,
        right: 16,
        child: Material(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(30),
          child: InkWell(
            onTap: () {
              if (controllerRestaurant.isFav.value) {
                controllerRestaurant.isFav.value = false;
                controller.deleteCart(restaurant.id.toString());
              } else {
                controllerRestaurant.isFav.value = true;
                controller.postCart(
                  Favourite(
                    id: restaurant.id,
                    city: restaurant.city,
                    name: restaurant.name,
                    pictureId: restaurant.pictureId,
                    rating: restaurant.rating,
                    isFavourite: 1,
                  ),
                );
              }
            },
            borderRadius: BorderRadius.circular(30),
            child: SizedBox(
              width: 48,
              height: 48,
              child: Padding(
                padding: const EdgeInsets.all(9.0),
                child: Icon(
                  Icons.favorite,
                  color: (controllerRestaurant.isFav.value)
                      ? Colors.red
                      : Colors.grey,
                  size: 32,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
