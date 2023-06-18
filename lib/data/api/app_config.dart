class ApiService {
  static String getApi() {
    return "https://restaurant-api.dicoding.dev";
  }

  static String getMediumImage(String pictureId) {
    return "https://restaurant-api.dicoding.dev/images/small/$pictureId";
  }
}
