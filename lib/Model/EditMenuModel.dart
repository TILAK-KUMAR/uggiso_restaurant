class EditMenuModel {
  int? statusCode;
  String? message;
  EditMenuPayload? payload;
  String? timeStamp;
  String? error;

  EditMenuModel({this.statusCode, this.message, this.payload, this.timeStamp});

  EditMenuModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    payload =
    json['payload'] != null ? new EditMenuPayload.fromJson(json['payload']) : null;
    timeStamp = json['timeStamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    if (this.payload != null) {
      data['payload'] = this.payload!.toJson();
    }
    data['timeStamp'] = this.timeStamp;
    return data;
  }
  EditMenuModel.withError(String errorMessage) {
    error = errorMessage;
  }
}

class EditMenuPayload {
  String? menuId;
  String? restaurantId;
  String? menuName;
  String? photo;
  String? description;
  String? menuType;
  String? restaurantMenuType;
  int? price;
  int? parcelCharges;
  bool? bestSeller;
  double? ratings;

  EditMenuPayload(
      {this.menuId,
        this.restaurantId,
        this.menuName,
        this.photo,
        this.description,
        this.menuType,
        this.restaurantMenuType,
        this.price,
        this.parcelCharges,
        this.bestSeller,
        this.ratings});

  EditMenuPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menuId'];
    restaurantId = json['restaurantId'];
    menuName = json['menuName'];
    photo = json['photo'];
    description = json['description'];
    menuType = json['menuType'];
    restaurantMenuType = json['restaurantMenuType'];
    price = json['price'];
    parcelCharges = json['parcelCharges'];
    bestSeller = json['bestSeller'];
    ratings = json['ratings'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menuId'] = this.menuId;
    data['restaurantId'] = this.restaurantId;
    data['menuName'] = this.menuName;
    data['photo'] = this.photo;
    data['description'] = this.description;
    data['menuType'] = this.menuType;
    data['restaurantMenuType'] = this.restaurantMenuType;
    data['price'] = this.price;
    data['parcelCharges'] = this.parcelCharges;
    data['bestSeller'] = this.bestSeller;
    data['ratings'] = this.ratings;
    return data;
  }
}