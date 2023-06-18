import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_api/data/api/app_config.dart';
import 'package:restaurant_api/data/models/detail_restaurant_model.dart';
import 'package:restaurant_api/data/models/restaurant_model.dart';
import 'package:restaurant_api/data/provider/restaurant_provider_network.dart';

import 'restaurant_list_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  const String getAllResto = '''
  {
    "error": false,
    "message": "success",
    "count": 2,
    "restaurants": [
      {
        "id": "rqdv5juczeskfw1e867",
        "name": "Melting Pot",
        "description": "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...",
        "pictureId": "14",
        "city": "Medan",
        "rating": 4.2
      },
      {
        "id": "s1knt6za9kkfw1e867",
        "name": "Kafe Kita",
        "description": "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. ...",
        "pictureId": "25",
        "city": "Gorontalo",
        "rating": 4
      }
    ]
  }
  ''';

  const String getDetailResto = '''
  {
    "error": false,
    "message": "success",
    "restaurant": {
      "id": "s1knt6za9kkfw1e867",
      "name": "Kafe Kita",
      "description": "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,",
      "city": "Gorontalo",
      "address": "Jln. Pustakawan no 9",
      "pictureId": "25",
      "categories": [
        {
          "name": "Sop"
        },
        {
          "name": "Modern"
        }
      ],
      "menus": {
        "foods": [
          {
            "name": "Kari kacang dan telur"
          },
          {
            "name": "Ikan teri dan roti"
          },
          {
            "name": "roket penne"
          },
          {
            "name": "Salad lengkeng"
          },
          {
            "name": "Tumis leek"
          },
          {
            "name": "Salad yuzu"
          },
          {
            "name": "Sosis squash dan mint"
          }
        ],
        "drinks": [
          {
            "name": "Jus tomat"
          },
          {
            "name": "Minuman soda"
          },
          {
            "name": "Jus apel"
          },
          {
            "name": "Jus mangga"
          },
          {
            "name": "Es krim"
          },
          {
            "name": "Kopi espresso"
          },
          {
            "name": "Jus alpukat"
          },
          {
            "name": "Coklat panas"
          },
          {
            "name": "Es kopi"
          },
          {
            "name": "Teh manis"
          },
          {
            "name": "Sirup"
          },
          {
            "name": "Jus jeruk"
          }
        ]
      },
      "rating": 4,
      "customerReviews": [
        {
          "name": "Ahmad",
          "review": "Tidak ada duanya!",
          "date": "13 November 2019"
        },
        {
          "name": "Arif",
          "review": "Tidak rekomendasi untuk pelajar!",
          "date": "13 November 2019"
        },
        {
          "name": "Gilang",
          "review": "Tempatnya bagus namun menurut saya masih sedikit mahal.",
          "date": "14 Agustus 2018"
        }
      ]
    }
  }
  ''';

  group('Test Restaurant API', () {
    final MockClient client = MockClient();
    final RestaurantProviderNetwork provider =
        RestaurantProviderNetwork(client);

    test('json parsing fetch all restaurant', () async {
      when(client.get(Uri.parse('${ApiService.getApi()}/list')))
          .thenAnswer((_) async => http.Response(getAllResto, 200));
      expect(await provider.getRestaurant(), isA<List<RestaurantModel>>());
    });

    test('json parsing fetch detail restaurant', () async {
      const String id = 's1knt6za9kkfw1e867';
      when(client.get(Uri.parse('${ApiService.getApi()}/detail/$id')))
          .thenAnswer((_) async => http.Response(getDetailResto, 200));
      expect(
          await provider.getDetailRestaurant(id), isA<DetailRestaurantModel>());
    });

    test('json parsing fetch search restaurant', () async {
      const String search = 'Mel';
      when(client.get(Uri.parse('${ApiService.getApi()}/search?q=$search')))
          .thenAnswer((_) async => http.Response(getAllResto, 200));
      expect(await provider.getRestaurant(), isA<List<RestaurantModel>>());
    });
  });
}
