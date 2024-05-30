import 'package:uggiso_restaurant/Model/AddFoodModel.dart';
import 'package:uggiso_restaurant/Model/GetRestaurantStatusModel.dart';
import 'package:uggiso_restaurant/Model/RegisterUserModel.dart';
import 'package:uggiso_restaurant/Model/RestaurantDetailsModel.dart';
import 'package:uggiso_restaurant/Model/RestaurantOrderModel.dart';
import 'package:uggiso_restaurant/Model/VerifyOtpModel.dart';
import 'package:uggiso_restaurant/Model/otpModel.dart';
import 'package:uggiso_restaurant/Network/apiProvider.dart';
import '../Model/DeleteFoodModel.dart';
import '../Model/RegisterRestaurantModel.dart';

class ApiRepository {
  final _provider = ApiProvider();

  String userUrl = 'https://reqres.in/api/users?page=2';


  Future<OtpModel> getOtp(String number) {
    return _provider.getOtp(number);
  }

  Future<VerifyOtpModel> verifyOtp(String? number,String otp) {
    return _provider.verifyOtp(number,otp);
  }

  Future<RegisterUserModel> registerUser(String name,String number,String userType,String deviceId,String token) {
    return _provider.registerUser(name,number,userType,deviceId,token);
  }

  Future<RegisterReataurantModel> registerRestaurant(String id,String name,String number,
      String address,String landmark,String city,String state,String accountNumber,String ifscCode,
      String upiData,String imageUrl,double lat, double lng) {
    return _provider.registerRestaurant(id,name,number,address,landmark,city,state,accountNumber,ifscCode,upiData,imageUrl,lat,lng);
  }



  Future<RestaurantDetailsModel> getResaturantDetails(String id) {
    return _provider.getRestaurantDetails(id);
  }

  Future<AddFoodModel> getAddedMenu(String id) {
    return _provider.getMenuList(id);
  }

  Future<AddFoodModel> addFood(String id,String title,String description,
      String menuType,String restaurantMenuType,String price,String bestSeller,String photo) {
    return _provider.addFoodItem(id,title,description,menuType,restaurantMenuType,price,bestSeller,photo);
  }

  Future<DeleteFoodModel> deleteFoodItem(String id) {
    return _provider.deleteMenuItem(id);
  }

  Future<GetRestaurantStatusModel> getRestaurantStatus(String id) {
    return _provider.getRestaurantStatus(id);
  }

  Future<RestaurantOrderModel> getRestaurantOrder(String id) {
    return _provider.getRestaurantOrder(id);
  }

}