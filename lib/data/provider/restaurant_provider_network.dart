import 'dart:convert';
import 'package:restaurant_api/data/api/app_config.dart';
import 'package:restaurant_api/data/models/detail_restaurant_model.dart';
import 'package:restaurant_api/data/models/restaurant_model.dart';
import 'package:restaurant_api/data/models/review_model.dart';
import 'package:http/http.dart' as http;

class RestaurantProviderNetwork {
  final http.Client client;
  final api = ApiService.getApi();
  RestaurantProviderNetwork(this.client);

  Future<List<RestaurantModel>> getRestaurant() async {
    var response = await client.get(
      Uri.parse('$api/list'),
    );

    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      var restaurant = responseData['restaurants'];
      List<RestaurantModel> list = restaurant
          .map<RestaurantModel>((data) => RestaurantModel.fromJson(data))
          .toList();
      return list;
    } else {
      throw Exception("Failed to fetch data");
    }
  }

  Future<DetailRestaurantModel> getDetailRestaurant(String id) async {
    var response = await client.get(
      Uri.parse('$api/detail/$id'),
    );

    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      var restaurant = responseData['restaurant'];
      DetailRestaurantModel details =
          DetailRestaurantModel.fromJson(restaurant);
      return details;
    } else {
      throw Exception("Failed to fetch data");
    }
  }

  Future<List<RestaurantModel>> getSearch(String search) async {
    var response = await client.get(
      Uri.parse('$api/search?q=$search'),
    );

    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      var restaurant = responseData['restaurants'];
      List<RestaurantModel> list = restaurant
          .map<RestaurantModel>((data) => RestaurantModel.fromJson(data))
          .toList();
      return list;
    } else {
      throw Exception("Failed to fetch data");
    }
  }

  Future<List<ReviewModel>> postReview(
      String id, String nameText, String reviewText) async {
    var response = await http.post(
      Uri.parse('$api/review'),
      headers: {
        "Content-Type": "application/json",
      },
      body: json.encode({
        "id": id,
        "name": nameText,
        "review": reviewText,
      }),
    );

    if (response.statusCode == 201) {
      var responseData = json.decode(response.body);
      var review = responseData["customerReviews"];

      List<ReviewModel> list = review
          .map<ReviewModel>((data) => ReviewModel.fromJson(data))
          .toList();

      return list;
    } else {
      throw Exception("Failed to fetch data");
    }
  }
}
