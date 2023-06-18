import 'package:get/get.dart';
import 'package:restaurant_api/data/enum/result_state.dart';
import 'package:restaurant_api/data/models/cart_db.dart';
import 'package:restaurant_api/data/locale/db_helper.dart';

class FavouriteController extends GetxController {
  @override
  void onInit() {
    getCart();
    super.onInit();
  }

  RxList<Favourite> listFav = RxList<Favourite>();
  Rx<ResultState> favouriteState = ResultState.loading.obs;

  Future<void> getCart() async {
    try {
      favouriteState.value = ResultState.loading;
      var response = await FavDatabase.instance.readAllCart();
      if (response.isEmpty) {
        favouriteState.value = ResultState.noData;
      } else {
        listFav.value = response;
        favouriteState.value = ResultState.hasData;
      }
    } catch (e) {
      favouriteState.value = ResultState.error;
    }
  }

  Future<void> postCart(Favourite favourite) async {
    await FavDatabase.instance.create(favourite);
    getCart();
  }

  Future<void> deleteCart(String id) async {
    await FavDatabase.instance.delete(id);
    getCart();
  }
}
