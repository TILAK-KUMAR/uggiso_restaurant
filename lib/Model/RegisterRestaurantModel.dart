
class RegisterReataurantModel {
  int? statusCode;
  String? message;
  Payload? payload;
  String? timeStamp;
  String? error;


  RegisterReataurantModel(
      {this.statusCode, this.message, this.payload, this.timeStamp});

  RegisterReataurantModel.fromJson(Map<String, dynamic> json) {
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

  RegisterReataurantModel.withError(String errorMessage) {
    error = errorMessage;
  }
}

class Payload {
  String? restaurantId;
  String? restaurantName;
  String? imageUrl;

  Payload({this.restaurantId, this.restaurantName, this.imageUrl});

  Payload.fromJson(Map<String, dynamic> json) {
    restaurantId = json['restaurantId'];
    restaurantName = json['restaurantName'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['restaurantId'] = this.restaurantId;
    data['restaurantName'] = this.restaurantName;
    data['imageUrl'] = this.imageUrl;
    return data;
  }
}