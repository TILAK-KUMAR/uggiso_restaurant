class RestaurantDetailsModel {
  int? statusCode;
  String? message;
  Payload? payload;
  String? timeStamp;
  String? error;

  RestaurantDetailsModel(
      {this.statusCode, this.message, this.payload, this.timeStamp});

  RestaurantDetailsModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    payload =
    json['payload'] != null ? new Payload.fromJson(json['payload']) : null;
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
  RestaurantDetailsModel.withError(String errorMessage) {
    error = errorMessage;
  }
}

class Payload {
  String? restaurantId;
  String? ownerId;
  String? restaurantName;
  String? phoneNumber;
  String? address;
  String? landmark;
  double? lat;
  double? lng;
  String? placeId;
  String? city;
  String? state;
  String? accountNumber;
  String? ifscCode;
  String? upiData;
  String? imageUrl;
  String? gstNumber;
  double? gstPercent;
  String? openTime;
  String? closeTime;
  String? restaurantStatus;
  String? restaurantMenuType;
  String? restaurantSize;
  double? ratings;
  String? createdDate;

  Payload(
      {this.restaurantId,
        this.ownerId,
        this.restaurantName,
        this.phoneNumber,
        this.address,
        this.landmark,
        this.lat,
        this.lng,
        this.placeId,
        this.city,
        this.state,
        this.accountNumber,
        this.ifscCode,
        this.upiData,
        this.imageUrl,
        this.gstNumber,
        this.gstPercent,
        this.openTime,
        this.closeTime,
        this.restaurantStatus,
        this.restaurantMenuType,
        this.restaurantSize,
        this.ratings,
        this.createdDate});

  Payload.fromJson(Map<String, dynamic> json) {
    restaurantId = json['restaurantId'];
    ownerId = json['ownerId'];
    restaurantName = json['restaurantName'];
    phoneNumber = json['phoneNumber'];
    address = json['address'];
    landmark = json['landmark'];
    lat = json['lat'];
    lng = json['lng'];
    placeId = json['placeId'];
    city = json['city'];
    state = json['state'];
    accountNumber = json['accountNumber'];
    ifscCode = json['ifscCode'];
    upiData = json['upiData'];
    imageUrl = json['imageUrl'];
    gstNumber = json['gstNumber'];
    gstPercent = json['gstPercent'];
    openTime = json['openTime'];
    closeTime = json['closeTime'];
    restaurantStatus = json['restaurantStatus'];
    restaurantMenuType = json['restaurantMenuType'];
    restaurantSize = json['restaurantSize'];
    ratings = json['ratings'];
    createdDate = json['createdDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['restaurantId'] = this.restaurantId;
    data['ownerId'] = this.ownerId;
    data['restaurantName'] = this.restaurantName;
    data['phoneNumber'] = this.phoneNumber;
    data['address'] = this.address;
    data['landmark'] = this.landmark;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['placeId'] = this.placeId;
    data['city'] = this.city;
    data['state'] = this.state;
    data['accountNumber'] = this.accountNumber;
    data['ifscCode'] = this.ifscCode;
    data['upiData'] = this.upiData;
    data['imageUrl'] = this.imageUrl;
    data['gstNumber'] = this.gstNumber;
    data['gstPercent'] = this.gstPercent;
    data['openTime'] = this.openTime;
    data['closeTime'] = this.closeTime;
    data['restaurantStatus'] = this.restaurantStatus;
    data['restaurantMenuType'] = this.restaurantMenuType;
    data['restaurantSize'] = this.restaurantSize;
    data['ratings'] = this.ratings;
    data['createdDate'] = this.createdDate;
    return data;
  }
}