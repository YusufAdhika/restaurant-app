class DetailRestaurantModel {
  String? id;
  String? name;
  String? description;
  String? city;
  String? address;
  String? pictureId;
  List<Categories>? categories;
  Menus? menus;
  num? rating;
  List<CustomerReviews>? customerReviews;

  DetailRestaurantModel(
      {this.id,
      this.name,
      this.description,
      this.city,
      this.address,
      this.pictureId,
      this.categories,
      this.menus,
      this.rating,
      this.customerReviews});

  DetailRestaurantModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    city = json['city'];
    address = json['address'];
    pictureId = json['pictureId'];
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(Categories.fromJson(v));
      });
    }
    menus = json['menus'] != null ? Menus.fromJson(json['menus']) : null;
    rating = json['rating'];
    if (json['customerReviews'] != null) {
      customerReviews = <CustomerReviews>[];
      json['customerReviews'].forEach((v) {
        customerReviews!.add(CustomerReviews.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['city'] = city;
    data['address'] = address;
    data['pictureId'] = pictureId;
    if (categories != null) {
      data['categories'] = categories!.map((v) => v.toJson()).toList();
    }
    if (menus != null) {
      data['menus'] = menus!.toJson();
    }
    data['rating'] = rating;
    if (customerReviews != null) {
      data['customerReviews'] =
          customerReviews!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Categories {
  String? name;

  Categories({this.name});

  Categories.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}

class Menus {
  List<Foods>? foods;
  List<Drinks>? drinks;

  Menus({this.foods, this.drinks});

  Menus.fromJson(Map<String, dynamic> json) {
    if (json['foods'] != null) {
      foods = <Foods>[];
      json['foods'].forEach((v) {
        foods!.add(Foods.fromJson(v));
      });
    }
    if (json['drinks'] != null) {
      drinks = <Drinks>[];
      json['drinks'].forEach((v) {
        drinks!.add(Drinks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (foods != null) {
      data['foods'] = foods!.map((v) => v.toJson()).toList();
    }
    if (drinks != null) {
      data['drinks'] = drinks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CustomerReviews {
  String? name;
  String? review;
  String? date;

  CustomerReviews({this.name, this.review, this.date});

  CustomerReviews.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    review = json['review'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['review'] = review;
    data['date'] = date;
    return data;
  }
}

class Foods {
  Foods({required this.name});

  String name;

  factory Foods.fromJson(Map<String, dynamic> json) => Foods(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {"name": name};
}

class Drinks {
  Drinks({required this.name});

  String name;

  factory Drinks.fromJson(Map<String, dynamic> json) => Drinks(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {"name": name};
}
