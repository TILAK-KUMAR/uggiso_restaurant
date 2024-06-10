import 'package:dio/dio.dart';
import 'package:uggiso_restaurant/Model/AddFoodModel.dart';
import 'package:uggiso_restaurant/Model/RegisterUserModel.dart';
import 'package:uggiso_restaurant/Model/RestaurantDetailsModel.dart';
import 'package:uggiso_restaurant/Model/RestaurantOrderModel.dart';
import 'package:uggiso_restaurant/Model/VerifyOtpModel.dart';
import 'package:uggiso_restaurant/Model/otpModel.dart';
import '../Model/DeleteFoodModel.dart';
import '../Model/EditMenuModel.dart';
import '../Model/GetRestaurantStatusModel.dart';
import '../Model/RegisterRestaurantModel.dart';
import 'constants.dart';


class ApiProvider {
  final Dio _dio = Dio();
  final String _url = Constants.baseUrl;

  Future<OtpModel> getOtp(String number) async {
    try {
      Response response = await _dio.post('${_url}${Constants.getOtp}',data: {
        "phoneNumber": number
      });
      print("${response.data}");
      return OtpModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return OtpModel.withError("Data not found / Connection issue");
    }
  }

  Future<VerifyOtpModel> verifyOtp(String? number,String otp) async {
    print('this is rewuest : $number and $otp');
    try {
      Response response = await _dio.post('${_url}${Constants.verifyOtp}',data: {
        "phoneNumber":number,
        "otp":otp
      });
      print("${response.data}");

      return VerifyOtpModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return VerifyOtpModel.withError("Data not found / Connection issue");
    }
  }

  Future<RegisterUserModel> registerUser(String name,String number,String userType,String deviceId,String token) async {
    try {
      Response response = await _dio.post('${_url}${Constants.registerUser}',data: {
        "name": name,
        "phoneNumber": number,
        "userType": userType,
        "deviceData": deviceId,
        "fcmToken": token
      });
      print("${response.data}");

      return RegisterUserModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return RegisterUserModel.withError("Data not found / Connection issue");
    }
  }

  Future<RegisterReataurantModel> registerRestaurant(String id,String name,String number,
      String address,String landmark,String city,String state,String accountNumber,String ifscCode,
      String upiData,String imageUrl, double lat, double lng) async {
    try {
      Response response = await _dio.post('${_url}${Constants.registerRestaurant}',data: {
        "ownerId":id,
        "restaurantName":name,
        "phoneNumber": number,
        "address": address,
        "landmark": landmark,
        "city": city,
        "state":state,
        "accountNumber":accountNumber,
        "ifscCode":ifscCode,
        "upiData":upiData,
        "imageUrl":imageUrl,
        "lat":lat,
        "lng":lng
      });
      print("${response.data}");

      return RegisterReataurantModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return RegisterReataurantModel.withError("Data not found / Connection issue");
    }
  }

  Future<RestaurantDetailsModel> getRestaurantDetails(String id) async {
    try {
      Response response = await _dio.get('${_url}${Constants.restaurantDetails}$id');
      print("${response.data}");

      return RestaurantDetailsModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return RestaurantDetailsModel.withError("Data not found / Connection issue");
    }
  }

  Future<AddFoodModel> getMenuList(String id) async {
    try {
      Response response = await _dio.get('${_url}${Constants.menuList}$id');
      print("${response.data}");

      return AddFoodModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return AddFoodModel.withError("Data not found / Connection issue");
    }
  }

  Future<AddFoodModel> addFoodItem(String id,String title,String description,
      String menuType,String restaurantMenuType,String price,String bestSeller,String photo) async {
    try {
      Response response = await _dio.post('${_url}${Constants.addFood}',data: {
        "restaurantId": id,
        "menuName": title,
        "description": description,
        "menuType": menuType,
        "restaurantMenuType": restaurantMenuType,
        "price": price,
        "bestSeller": bestSeller,
        "photo": photo
      });
      print("${response.data}");
      return AddFoodModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return AddFoodModel.withError("Data not found / Connection issue");
    }
  }

  Future<DeleteFoodModel> deleteMenuItem(String id) async {
    try {
      Response response = await _dio.delete('${_url}${Constants.menuList}$id');
      print("${response.data}");

      return DeleteFoodModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return DeleteFoodModel.withError("Data not found / Connection issue");
    }
  }

  Future<GetRestaurantStatusModel> getRestaurantStatus(String id) async {
    try {
      print('url : ${_url}${Constants.getRestaurantStatus}$id');
      Response response = await _dio.get('${_url}${Constants.getRestaurantStatus}$id');
      print("${response.data}");

      return GetRestaurantStatusModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return GetRestaurantStatusModel.withError("Data not found / Connection issue");
    }
  }

  Future<RestaurantOrderModel> getRestaurantOrder(String id) async {
    try {
      print('url : ${_url}${Constants.getRestaurantOrder}$id');
      Response response = await _dio.get('${_url}${Constants.getRestaurantOrder}$id');
      print("${response.data}");

      return RestaurantOrderModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return RestaurantOrderModel.withError("Data not found / Connection issue");
    }
  }

  Future<EditMenuModel> editFoodItem(String menuId,String restaurantId,String menuName,String description,
      String menuType,bool veg,String price,bool bestSeller,String photo) async {

    try {
      Response response = await _dio.put('${_url}${Constants.editMenu}',data: {
        "menuId": menuId,
        "restaurantId": restaurantId,
        "menuName": menuName,
        "photo": photo,
        "description": description,
        "menuType": menuType,
        "veg": veg,
        "price": price,
        "bestSeller": bestSeller
      });
      print("${response.data}");
      return EditMenuModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return EditMenuModel.withError("Data not found / Connection issue");
    }
  }
}