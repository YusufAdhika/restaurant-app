import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_api/controllers/favourite_controller.dart';
import 'package:restaurant_api/controllers/restaurant_controller.dart';
import 'package:restaurant_api/data/api/app_config.dart';
import 'package:restaurant_api/data/models/cart_db.dart';

class CardFavourite extends StatelessWidget {
  CardFavourite({required this.restaurant, super.key});

  final Favourite restaurant;
  final controller = Get.put(RestaurantController());
  final controllerFav = Get.put(FavouriteController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18, right: 18, top: 18),
      child: Container(
        height: 112,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.14),
              spreadRadius: 0,
              blurRadius: 14,
            )
          ],
        ),
        child: Material(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () {
              controller.getDetailRestaurant(
                  restaurant.id!, controllerFav.listFav);
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.network(
                    ApiService.getMediumImage(
                      restaurant.pictureId.toString(),
                    ),
                    width: 115,
                    height: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace? stackTrace) {
                      return Image.asset(
                        'assets/placeholder.png',
                        width: 115,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        restaurant.city.toString(),
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      Text(
                        restaurant.name.toString(),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        restaurant.rating.toString(),
                        style: Theme.of(context).textTheme.titleSmall,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
