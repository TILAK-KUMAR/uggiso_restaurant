class GetRestaurantStatusModel {
  int? statusCode;
  String? message;
  Payload? payload;
  String? timeStamp;
  String? error;


  GetRestaurantStatusModel(
      {this.statusCode, this.message, this.payload, this.timeStamp});

  GetRestaurantStatusModel.fromJson(Map<String, dynamic> json) {
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

  GetRestaurantStatusModel.withError(String errorMessage) {
    error = errorMessage;
  }
}

class Payload {
  String? restaurantId;
  Null? restaurantStatus;

  Payload({this.restaurantId, this.restaurantStatus});

  Payload.fromJson(Map<String, dynamic> json) {
    restaurantId = json['restaurantId'];
    restaurantStatus = json['restaurantStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['restaurantId'] = this.restaurantId;
    data['restaurantStatus'] = this.restaurantStatus;
    return data;
  }
}