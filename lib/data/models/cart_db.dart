const String tableFavourite = 'cart';

class FavouriteFields {
  static final List<String> values = [
    id,
    name,
    isFavourite,
    pictureId,
    city,
    rating
  ];

  static const String id = 'id';
  static const String name = 'name';
  static const String isFavourite = 'isFavourite';
  static const String pictureId = 'pictureId';
  static const String city = 'city';
  static const String rating = 'rating';
}

class Favourite {
  String? id;
  String? name;
  int? isFavourite;
  String? pictureId;
  String? city;
  num? rating;

  Favourite({
    this.id,
    this.name,
    this.isFavourite,
    this.pictureId,
    this.city,
    this.rating,
  });

  Favourite copy({
    String? id,
    String? name,
    int? isFavourite,
    String? pictureId,
    String? city,
    num? rating,
  }) =>
      Favourite(
          id: id ?? this.id,
          name: name ?? this.name,
          isFavourite: isFavourite ?? this.isFavourite,
          pictureId: pictureId ?? this.pictureId,
          city: city ?? this.city,
          rating: rating ?? this.rating);

  static Favourite fromJson(Map<String, Object?> json) => Favourite(
        id: json[FavouriteFields.id] as String,
        name: json[FavouriteFields.name] as String,
        isFavourite: json[FavouriteFields.isFavourite] as int,
        pictureId: json[FavouriteFields.pictureId] as String,
        city: json[FavouriteFields.city] as String,
        rating: json[FavouriteFields.rating] as num,
      );

  Map<String, Object?> toJson() => {
        FavouriteFields.id: id,
        FavouriteFields.name: name,
        FavouriteFields.isFavourite: isFavourite,
        FavouriteFields.pictureId: pictureId,
        FavouriteFields.city: city,
        FavouriteFields.rating: rating,
      };
}
