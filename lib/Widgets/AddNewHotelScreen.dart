import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uggiso_restaurant/Bloc/RegisterHotelBloc/RegisterHotelEvent.dart';
import 'package:uggiso_restaurant/Widgets/ui-kit/RoundedContainer.dart';
import 'package:uggiso_restaurant/Widgets/ui-kit/RoundedElevatedButton.dart';
import 'package:uggiso_restaurant/Widgets/ui-kit/TextFieldCurvedEdges.dart';
import '../Bloc/RegisterHotelBloc/RegisterHotelBloc.dart';
import '../Bloc/RegisterHotelBloc/RegisterHotelState.dart';
import '../app_routes.dart';
import '../base/common/utils/colors.dart';
import '../base/common/utils/fonts.dart';
import '../base/common/utils/strings.dart';

class AddNewHotelScreen extends StatefulWidget {
  const AddNewHotelScreen({super.key});

  @override
  State<AddNewHotelScreen> createState() => _AddNewHotelScreenState();
}

class _AddNewHotelScreenState extends State<AddNewHotelScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _upiIdController = TextEditingController();
  final TextEditingController _accountNumberController = TextEditingController();
  final TextEditingController _ifscController = TextEditingController();
  final TextEditingController _aadharController = TextEditingController();
  final TextEditingController _gstController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _landmarkController = TextEditingController();

  final RegisterHotelBloc _registerHotelBloc = RegisterHotelBloc();

  String selectedState = 'Karnataka';
  String selectedHotelType = 'Street Hotel';
  String hotelOpeningHours = '5:00 AM';
  String hotelClosingHours = '11:00 PM';
  String selectedCusineType = 'Indian';
  String userContactNumber = '';
  String ownerId = '';

  @override
  void initState() {
    getUserNumber(false,'');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _registerHotelBloc,
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Text(Strings.hotel_details,
              style:
              AppFonts.appBarText.copyWith(color: AppColors.appPrimaryColor)),
          leading:  IconButton(
            icon: Image.asset('assets/ic_back.png',width: 16,height: 16,color: AppColors.black,),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: AppColors.white,
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 16.0, vertical: 8.0),
            child: BlocBuilder<RegisterHotelBloc, RegisterHotelState>(
                builder: (context, state) {
                  if (state is LoadingState) {
                    return const Center(child: CircularProgressIndicator(
                      color: AppColors.white,));
                  }
                  else if (state is onLoadedState) {
                    if(state.id==null){
                      return mainWidget();
                    }
                    else {
                      getUserNumber(true, state.id!);
                      return Container();
                    }
                  }
                  else {
                    return mainWidget();
                  }
                }
            ),
          ),
        ),
      ),
    );
  }

  Widget mainWidget() =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(Strings.hotel_name,
              style: AppFonts.title.copyWith(color: AppColors.textColor)),
          const SizedBox(height: 10.0),
          TextFieldCurvedEdges(
            controller: _nameController,
            backgroundColor: AppColors.white,
            keyboardType: TextInputType.name,
            borderColor: AppColors.borderColor,
            borderRadius: 6,
          ),
          const SizedBox(height: 10.0),
          Text(Strings.hotel_type,
              style: AppFonts.title.copyWith(color: AppColors.textColor)),
          const SizedBox(height: 10.0),
          RoundedContainer(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.05,
              color: AppColors.white,
              cornerRadius: 12,
              padding: 0,
              child: DropdownButtonFormField(
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 0),
                  border: InputBorder.none,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 18),
                value: selectedHotelType,
                menuMaxHeight: MediaQuery
                    .of(context)
                    .size
                    .height * 0.4,
                icon: Image.asset(
                  'assets/ic_dropdown_arrow.png',
                  width: 12.0,
                  height: 12.0,
                ),
                items: Strings.hotel_type_list.map((String value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedHotelType = newValue!;
                  });
                },
              )),
          const SizedBox(height: 10.0),
          Text(Strings.address,
              style: AppFonts.title.copyWith(color: AppColors.textColor)),
          const SizedBox(height: 10.0),
          TextFieldCurvedEdges(
            controller: _addressController,
            backgroundColor: AppColors.white,
            keyboardType: TextInputType.name,
            borderColor: AppColors.borderColor,
            borderRadius: 6,
          ),
          const SizedBox(height: 10.0),
          Text(Strings.state,
              style: AppFonts.title.copyWith(color: AppColors.textColor)),
          const SizedBox(height: 10.0),
          RoundedContainer(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.05,
              color: AppColors.white,
              cornerRadius: 12,
              padding: 0,
              child: DropdownButtonFormField(
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 0),
                  border: InputBorder.none,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 18),
                value: selectedState,
                menuMaxHeight: MediaQuery
                    .of(context)
                    .size
                    .height * 0.4,
                icon: Image.asset(
                  'assets/ic_dropdown_arrow.png',
                  width: 12.0,
                  height: 12.0,
                ),
                items: Strings.indian_states.map((String value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedState = newValue!;
                  });
                },
              )),
          const SizedBox(height: 10.0),

          Text(Strings.city,
              style: AppFonts.title.copyWith(color: AppColors.textColor)),
          const SizedBox(height: 10.0),
          TextFieldCurvedEdges(
            controller: _cityController,
            backgroundColor: AppColors.white,
            keyboardType: TextInputType.text,
            borderColor: AppColors.borderColor,
            borderRadius: 6,
          ),
          const SizedBox(height: 10.0),
          Text(Strings.landmark,
              style: AppFonts.title.copyWith(color: AppColors.textColor)),
          const SizedBox(height: 10.0),
          TextFieldCurvedEdges(
            controller: _landmarkController,
            backgroundColor: AppColors.white,
            keyboardType: TextInputType.text,
            borderColor: AppColors.borderColor,
            borderRadius: 6,
          ),
          const SizedBox(height: 10.0),
          const SizedBox(height: 10.0),
          Text(Strings.cuisine_Type,
              style: AppFonts.title.copyWith(color: AppColors.textColor)),
          const SizedBox(height: 10.0),
          RoundedContainer(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.05,
              color: AppColors.white,
              cornerRadius: 12,
              padding: 0,
              child: DropdownButtonFormField(
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 0),
                  border: InputBorder.none,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 18),
                value: selectedCusineType,
                menuMaxHeight: MediaQuery
                    .of(context)
                    .size
                    .height * 0.4,
                icon: Image.asset(
                  'assets/ic_dropdown_arrow.png',
                  width: 12.0,
                  height: 12.0,
                ),
                items: Strings.cuisine_type_list.map((String value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedCusineType = newValue!;
                  });
                },
              )),
          const SizedBox(height: 10.0),
          Text(Strings.operating_Hours,
              style: AppFonts.title.copyWith(color: AppColors.textColor)),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RoundedContainer(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.4,
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.05,
                  color: AppColors.white,
                  cornerRadius: 12,
                  padding: 0,
                  child: DropdownButtonFormField(
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 0),
                      border: InputBorder.none,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 1),
                    value: hotelOpeningHours,
                    menuMaxHeight: MediaQuery
                        .of(context)
                        .size
                        .height * 0.45,
                    icon: Image.asset(
                      'assets/ic_dropdown_arrow.png',
                      width: 12.0,
                      height: 12.0,
                    ),
                    items: Strings.opening_hour_list.map((String value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        hotelOpeningHours = newValue!;
                      });
                    },
                  )),

              RoundedContainer(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.45,
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.05,
                  color: AppColors.white,
                  cornerRadius: 12,
                  padding: 0,
                  child: DropdownButtonFormField(
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 0),
                      border: InputBorder.none,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    value: hotelClosingHours,
                    menuMaxHeight: MediaQuery
                        .of(context)
                        .size
                        .height * 0.4,
                    icon: Image.asset(
                      'assets/ic_dropdown_arrow.png',
                      width: 12.0,
                      height: 12.0,
                    ),
                    items: Strings.opening_hour_list.map((String value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        hotelClosingHours = newValue!;
                      });
                    },
                  )),
            ],
          ),
          const SizedBox(height: 10.0),
          Text(Strings.upi_id,
              style: AppFonts.title.copyWith(color: AppColors.textColor)),
          const SizedBox(height: 10.0),
          TextFieldCurvedEdges(
            controller: _upiIdController,
            backgroundColor: AppColors.white,
            keyboardType: TextInputType.emailAddress,
            borderColor: AppColors.borderColor,
            borderRadius: 6,
          ),
          const SizedBox(height: 10.0),
          Text(Strings.accountNumber,
              style: AppFonts.title.copyWith(color: AppColors.textColor)),
          const SizedBox(height: 10.0),
          TextFieldCurvedEdges(
            controller: _accountNumberController,
            backgroundColor: AppColors.white,
            keyboardType: TextInputType.phone,
            borderColor: AppColors.borderColor,
            borderRadius: 6,
          ),
          const SizedBox(height: 10.0),
          Text(Strings.ifsc_code,
              style: AppFonts.title.copyWith(color: AppColors.textColor)),
          const SizedBox(height: 10.0),
          TextFieldCurvedEdges(
            controller: _ifscController,
            backgroundColor: AppColors.white,
            keyboardType: TextInputType.text,
            borderColor: AppColors.borderColor,
            borderRadius: 6,
          ),
          const SizedBox(height: 10.0),
          Text(Strings.aadhar_card,
              style: AppFonts.title.copyWith(color: AppColors.textColor)),
          const SizedBox(height: 10.0),
          TextFieldCurvedEdges(
            controller: _aadharController,
            backgroundColor: AppColors.white,
            keyboardType: TextInputType.phone,
            borderColor: AppColors.borderColor,
            borderRadius: 6,
          ),
          const SizedBox(height: 10.0),
          Text(Strings.gst_Number,
              style: AppFonts.title.copyWith(color: AppColors.textColor)),
          const SizedBox(height: 10.0),
          TextFieldCurvedEdges(
            controller: _gstController,
            backgroundColor: AppColors.white,
            keyboardType: TextInputType.name,
            borderColor: AppColors.borderColor,
            borderRadius: 6,
          ),
          const SizedBox(height: 10.0),
          Text(Strings.hotel_image,
              style: AppFonts.title.copyWith(color: AppColors.textColor)),
          const SizedBox(height: 10.0),
          Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.only(bottom: 10),
            child: RoundedElevatedButton(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                height: 40.0,
                text: Strings.submit,
                onPressed: () {
                  registerHotel();
                  // _showBottomSheet(context);
                },
                cornerRadius: 6.0,
                buttonColor: AppColors.appPrimaryColor,
                textStyle:
                AppFonts.header.copyWith(color: AppColors.white)),
          ),
        ],
      );

  void getUserNumber(bool isRestaurantCreated,String id) async {
    final prefs = await SharedPreferences.getInstance();
    if(!isRestaurantCreated){
      setState(() {
        userContactNumber = prefs.getString('mobile_number') ?? '';
        ownerId = prefs.getString('user_id') ?? '';
      });
    }
    else{
      prefs.setString('restaurant_id', id);
      // _showBottomSheet(context);
      Navigator.popAndPushNamed(context, AppRoutes.pendingOnboarding);
    }

  }

  void registerHotel() {
    _registerHotelBloc.add(OnSubmitButtonClicked(id: ownerId,
        name: _nameController.text,
        phone: userContactNumber,
        address: _addressController.text,
        landmark: _landmarkController.text,
        city: _cityController.text,
        state: selectedState,
        accountNumber: _accountNumberController.text,
        ifsc: _ifscController.text,
        upi: _upiIdController.text,
        image: 'image'));
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isDismissible: false,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height*0.4,
          decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32), topRight: Radius.circular(24)),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.asset('assets/ic_onboarding_success.png',height: 100,width: 100,),
                Gap(18),
                Text(
                  Strings.thankyou,
                  style:AppFonts.subHeader.copyWith(fontWeight: FontWeight.w600,color: AppColors.appPrimaryColor),
                ),
                Gap(18),
                Text(
                  Strings.requestSent,
                  style:AppFonts.title.copyWith(fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                Gap(18),
                RoundedElevatedButton(
                  onPressed: () {
                    exit(0);
                    // Navigator.pop(context); // Close the bottom sheet
                  },
                  width: MediaQuery.of(context).size.width*0.2,
                  height: MediaQuery.of(context).size.height*0.04,
                  text: 'OK',
                  cornerRadius: 18,
                  buttonColor: AppColors.appPrimaryColor,
                  textStyle: AppFonts.header.copyWith(color: AppColors.white),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
