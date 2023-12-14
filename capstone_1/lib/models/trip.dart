class Trip {
  int? id;
  String? title;
  String? date;
  String? time;
  String? location;
  String? category;
  num? cost;
  String? description;
  String? tripCreator;
  String? image;

  Trip(
      {this.id,
      this.title,
      this.image,
      this.date,
      this.time,
      this.location,
      this.category,
      this.cost,
      this.description,
      this.tripCreator});

  Trip.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    date = json['date'];
    time = json['time'];
    image = json['image'];
    location = json['location'];
    category = json['category'];
    cost = json['cost'];
    description = json['description'];
    tripCreator = json['creator_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['date'] = date;
    data['time'] = time;
    data['location'] = location;
    data['image'] = image;
    data['category'] = category;
    data['cost'] = cost;
    data['description'] = description;
    data['creator_id'] = tripCreator;
    return data;
  }
}
