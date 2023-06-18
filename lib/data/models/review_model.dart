class ReviewModel {
  String? name;
  String? review;
  String? date;

  ReviewModel({this.name, this.review, this.date});

  ReviewModel.fromJson(Map<String, dynamic> json) {
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
