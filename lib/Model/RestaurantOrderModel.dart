class RestaurantOrderModel {
  int? statusCode;
  String? message;
  List<Payload>? payload;
  String? timeStamp;
  String? error;


  RestaurantOrderModel(
      {this.statusCode, this.message, this.payload, this.timeStamp});

  RestaurantOrderModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    if (json['payload'] != null) {
      payload = <Payload>[];
      json['payload'].forEach((v) {
        payload!.add(new Payload.fromJson(v));
      });
    }
    timeStamp = json['timeStamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    if (this.payload != null) {
      data['payload'] = this.payload!.map((v) => v.toJson()).toList();
    }
    data['timeStamp'] = this.timeStamp;
    return data;
  }

  RestaurantOrderModel.withError(String errorMessage) {
    error = errorMessage;
  }
}

class Payload {
  String? orderId;
  String? restaurantId;
  String? customerId;
  String? paymentType;
  String? orderStatus;
  String? timeSlot;
  double? totalAmount;
  double? discount;
  String? comments;
  String? orderDate;
  String? orderTime;

  Payload(
      {this.orderId,
        this.restaurantId,
        this.customerId,
        this.paymentType,
        this.orderStatus,
        this.timeSlot,
        this.totalAmount,
        this.discount,
        this.comments,
        this.orderDate,
        this.orderTime});

  Payload.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    restaurantId = json['restaurantId'];
    customerId = json['customerId'];
    paymentType = json['paymentType'];
    orderStatus = json['orderStatus'];
    timeSlot = json['timeSlot'];
    totalAmount = json['totalAmount'];
    discount = json['discount'];
    comments = json['comments'];
    orderDate = json['orderDate'];
    orderTime = json['orderTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderId'] = this.orderId;
    data['restaurantId'] = this.restaurantId;
    data['customerId'] = this.customerId;
    data['paymentType'] = this.paymentType;
    data['orderStatus'] = this.orderStatus;
    data['timeSlot'] = this.timeSlot;
    data['totalAmount'] = this.totalAmount;
    data['discount'] = this.discount;
    data['comments'] = this.comments;
    data['orderDate'] = this.orderDate;
    data['orderTime'] = this.orderTime;
    return data;
  }
}