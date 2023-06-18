import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:restaurant_api/data/api/app_config.dart';
import 'package:restaurant_api/data/models/detail_restaurant_model.dart';
import 'package:restaurant_api/views/review_view.dart';
import 'package:restaurant_api/widgets/love_icon.dart';

class DetailRestaurant extends StatelessWidget {
  const DetailRestaurant({
    required this.restaurant,
    super.key,
  });

  final DetailRestaurantModel restaurant;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Stack(
          children: [
            ClipRRect(
              child: Image.network(
                ApiService.getMediumImage(
                  restaurant.pictureId.toString(),
                ),
                width: double.infinity,
                height: 300,
                fit: BoxFit.fitHeight,
              ),
            ),
            LoveIcon(restaurant: restaurant)
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                restaurant.name.toString(),
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  const Icon(Icons.pin_drop),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    restaurant.city.toString(),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Text(
                    "Rating  :",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  RatingBarIndicator(
                    rating: 4,
                    itemBuilder: (context, index) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    itemSize: 20,
                  ),
                  Text(
                    " / ${restaurant.rating.toString()}",
                    style: Theme.of(context).textTheme.titleSmall,
                  )
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Material(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
                child: InkWell(
                  onTap: () {
                    Get.to(
                      () => ReviewView(
                        id: restaurant.id.toString(),
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Text(
                      "See Review Restaurant",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                restaurant.description.toString(),
                style: Theme.of(context).textTheme.bodySmall,
              )
            ],
          ),
        ),
        Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 18,
            ),
            child: Text(
              "Foods :",
              style: Theme.of(context).textTheme.titleSmall,
            )),
        SizedBox(
          height: 120,
          width: double.infinity,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: restaurant.menus!.foods!.length,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(
              horizontal: 18,
            ),
            itemBuilder: (context, index) {
              var foods = restaurant.menus!.foods![index];
              return Padding(
                padding: const EdgeInsets.only(
                  right: 18,
                  bottom: 18,
                  top: 18,
                ),
                child: Container(
                  height: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.20),
                          spreadRadius: 0,
                          blurRadius: 14,
                        )
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          child: Image.asset(
                            'assets/chicken.png',
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Text(
                          foods.name,
                          style: Theme.of(context).textTheme.titleSmall,
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
          ),
          child: Text(
            "Drinks :",
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        SizedBox(
          height: 120,
          width: double.infinity,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: restaurant.menus!.drinks!.length,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(
              horizontal: 18,
            ),
            itemBuilder: (context, index) {
              var drinks = restaurant.menus!.drinks![index];
              return Padding(
                padding: const EdgeInsets.only(
                  right: 18,
                  bottom: 18,
                  top: 18,
                ),
                child: Container(
                  // height: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.20),
                          spreadRadius: 0,
                          blurRadius: 14,
                        )
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          child: Image.asset(
                            'assets/drink.png',
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Text(
                          drinks.name,
                          style: Theme.of(context).textTheme.titleSmall,
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
