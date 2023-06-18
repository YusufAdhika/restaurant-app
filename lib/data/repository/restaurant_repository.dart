import 'package:restaurant_api/data/models/detail_restaurant_model.dart';
import 'package:restaurant_api/data/models/restaurant_model.dart';
import 'package:restaurant_api/data/models/review_model.dart';
import 'package:restaurant_api/data/provider/restaurant_provider_network.dart';

class RestaurantRepository {
  RestaurantProviderNetwork providerNetwork;
  RestaurantRepository({required this.providerNetwork});

  Future<List<RestaurantModel>> getRestaurant() =>
      providerNetwork.getRestaurant();

  Future<DetailRestaurantModel> getDetailRestaurant(String id) =>
      providerNetwork.getDetailRestaurant(id);

  Future<List<RestaurantModel>> getSearch(String search) =>
      providerNetwork.getSearch(search);

  Future<List<ReviewModel>> postReview(String id, String name, String review) =>
   providerNetwork.postReview(id, name, review);
  
}
