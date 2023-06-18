import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_api/data/enum/result_state.dart';
import 'package:restaurant_api/data/models/cart_db.dart';
import 'package:restaurant_api/data/models/detail_restaurant_model.dart';
import 'package:restaurant_api/data/models/restaurant_model.dart';
import 'package:restaurant_api/data/models/review_model.dart';
import 'package:restaurant_api/data/provider/restaurant_provider_network.dart';
import 'package:restaurant_api/data/repository/restaurant_repository.dart';
import 'package:restaurant_api/routes/routes_name.dart';
import 'package:restaurant_api/views/detail_view.dart';
import 'package:http/http.dart' as http;

class RestaurantController extends GetxController {
  @override
  void onInit() {
    getRestaurant();
    searchState.value = ResultState.noData;   
    searchList.value = []; 
    super.onInit();
  }

  RxString selectedOption = ''.obs;

  void handleMenuSelection(String value) {
    selectedOption.value = value;
    switch (value) {
      case 'search':
        searchList.value = [];
        searchState.value = ResultState.noData;
        Get.toNamed(RoutesName.searchView);
        break;
      case 'favourite':
        Get.toNamed(RoutesName.favouriteView);
      case 'setting':
        Get.toNamed(RoutesName.settingView);
        break;
    }
  }

  late RestaurantRepository _repository;
  RestaurantController() {
    _repository = RestaurantRepository(
      providerNetwork: RestaurantProviderNetwork(http.Client()),
    );
  }
  RxBool isFav = false.obs;
  RxString searchText = ''.obs;
  TextEditingController nameText = TextEditingController();
  TextEditingController reviewText = TextEditingController();
  RxList<RestaurantModel> restaurantsList = RxList<RestaurantModel>();
  RxList<RestaurantModel> searchList = RxList<RestaurantModel>();
  RxList<ReviewModel> reviewList = RxList<ReviewModel>();
  Rx<ResultState> resultState = ResultState.loading.obs;
  Rx<ResultState> detailState = ResultState.loading.obs;
  Rx<ResultState> searchState = ResultState.noData.obs;
  Rx<ResultState> reviewState = ResultState.noData.obs;

  Future<void> getRestaurant() async {
    try {
      resultState.value = ResultState.loading;
      List<RestaurantModel> response = await _repository.getRestaurant();
      if (response.isEmpty) {
        resultState.value = ResultState.noData;
      } else {
        restaurantsList.value = response;
        resultState.value = ResultState.hasData;
      }
    } catch (e) {
      resultState.value = ResultState.error;
    }
  }

  Future<void> getDetailRestaurant(String id, List<Favourite> favourite) async {
    try {
      isFav.value = false;
      reviewList.value = [];
      reviewState.value = ResultState.noData;
      for (var element in favourite) {
        if (id == element.id) {
          isFav.value = true;
        }
      }
      detailState.value = ResultState.loading;
      DetailRestaurantModel response =
          await _repository.getDetailRestaurant(id);
      if (response.id != null) {
        detailState.value = ResultState.hasData;
        Get.to(
          () => DetailView(
            restaurant: response,
          ),
          transition: Transition.rightToLeft,
          duration: const Duration(milliseconds: 600),
        );
      } else {
        detailState.value = ResultState.noData;
      }
    } catch (e) {
      detailState.value = ResultState.error;
    }
  }

  Future<void> getSearch(String search) async {
    try {
      searchState.value = ResultState.loading;
      List<RestaurantModel> response = await _repository.getSearch(search);
      if (response.isEmpty) {
        searchState.value = ResultState.noData;
      } else {
        searchList.value = response;
        searchState.value = ResultState.hasData;
      }
    } catch (e) {
      searchState.value = ResultState.error;
    }
  }

  Future<void> postReview(String id, String name, String review) async {
    try {
      reviewState.value = ResultState.loading;
      List<ReviewModel> response =
          await _repository.postReview(id, name, review);
      if (response.isEmpty) {
        reviewState.value = ResultState.noData;
      } else {
        reviewList.value = response;
        reviewState.value = ResultState.hasData;
      }
    } catch (e) {
      reviewState.value = ResultState.error;
    }
  }
}
