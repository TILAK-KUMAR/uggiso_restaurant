import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
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
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


class AddNewHotelScreen extends StatefulWidget {
  const AddNewHotelScreen({super.key});

  @override
  State<AddNewHotelScreen> createState() => _AddNewHotelScreenState();
}
class _AddNewHotelScreenState extends State<AddNewHotelScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _upiIdController = TextEditingController();
  final TextEditingController _gstPercentageController = TextEditingController();
  late GoogleMapController mapController;
  final ImagePicker _imagePicker = ImagePicker();
  final TextEditingController _accountNumberController = TextEditingController();
  final TextEditingController _ifscController = TextEditingController();
  final TextEditingController _gstController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _landmarkController = TextEditingController();
  File? _image;
  String foodImage = '';
  final RegisterHotelBloc _registerHotelBloc = RegisterHotelBloc();

  String selectedState = 'Karnataka';
  String selectedHotelType = 'Street Hotel';
  String hotelOpeningHours = '5:00 AM';
  String hotelClosingHours = '11:00 PM';
  String selectedCusineType = 'VEG';
  String userContactNumber = '';
  String ownerId = '';
  double? lat = 0.0;
  double? lng = 0.0;

  @override
  void initState() {
    getUserNumber(false, '');
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
              style: AppFonts.appBarText
                  .copyWith(color: AppColors.appPrimaryColor)),
          leading: IconButton(
            icon: Image.asset(
              'assets/ic_back.png',
              width: 16,
              height: 16,
              color: AppColors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: AppColors.white,
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: BlocBuilder<RegisterHotelBloc, RegisterHotelState>(
                builder: (context, state) {
              if (state is LoadingState) {
                return const Center(
                    child: CircularProgressIndicator(
                  color: AppColors.white,
                ));
              } else if (state is onLoadedState) {
                if (state.id == null) {
                  return mainWidget(context);
                } else {
                  getUserNumber(true, state.id!,context);
                  return Container();
                }
              } else {
                return mainWidget(context);
              }
            }),
          ),
        ),
      ),
    );
  }

  Widget mainWidget(BuildContext context) => Column(
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
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.05,
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
                menuMaxHeight: MediaQuery.of(context).size.height * 0.4,
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
          // const SizedBox(height: 10.0),
          Text(Strings.restaurant_menu_type,
              style: AppFonts.title.copyWith(color: AppColors.textColor)),
          const SizedBox(height: 10.0),
          RoundedContainer(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.05,
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
                menuMaxHeight: MediaQuery.of(context).size.height * 0.4,
                icon: Image.asset(
                  'assets/ic_dropdown_arrow.png',
                  width: 12.0,
                  height: 12.0,
                ),
                items: Strings.menu_Type_List.map((String value) {
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
          Text(Strings.gst_Number,
              style: AppFonts.title.copyWith(color: AppColors.textColor)),
          const SizedBox(height: 10.0),
          TextFieldCurvedEdges(
            controller: _gstController,
            backgroundColor: AppColors.white,
            keyboardType: TextInputType.text,
            borderColor: AppColors.borderColor,
            borderRadius: 6,
          ),
          const SizedBox(height: 10.0),
          Text(Strings.gst_percentage,
              style: AppFonts.title.copyWith(color: AppColors.textColor)),
          const SizedBox(height: 10.0),
          TextFieldCurvedEdges(
            controller: _gstPercentageController,
            backgroundColor: AppColors.white,
            keyboardType: TextInputType.number,
            borderColor: AppColors.borderColor,
            borderRadius: 6,
          ),
         const SizedBox(height: 10.0),
          Text(Strings.hotel_image,
              style: AppFonts.title.copyWith(color: AppColors.textColor)),
          const SizedBox(height: 10.0),
          // UploadPicture(context),
          InkWell(
            onTap: () => captureImage(),
            child: RoundedContainer(
                width: MediaQuery.of(context).size.width * 0.2,
                height: MediaQuery.of(context).size.height * 0.1,
                cornerRadius: 20,
                borderColor: AppColors.white,
                padding: 0,
                child: _image == null
                    ? Image.asset('assets/ic_upload_picture.png')
                    : Image.file(
                  _image! as File,
                  alignment: Alignment.center,
                  fit: BoxFit.fill,
                )),
          ),
          const SizedBox(height: 10.0),
          Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.only(bottom: 10),
            child: RoundedElevatedButton(
                width: MediaQuery.of(context).size.width,
                height: 40.0,
                text: Strings.submit,
                onPressed: () {
                  registerHotel();
                },
                cornerRadius: 6.0,
                buttonColor: AppColors.appPrimaryColor,
                textStyle: AppFonts.header.copyWith(color: AppColors.white)),
          ),
        ],
      );

  void getUserNumber(bool isRestaurantCreated, String id,[BuildContext? context]) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      lat =  prefs.getDouble('user_latitude');
      lng =  prefs.getDouble('user_longitude');

    });

    if (!isRestaurantCreated) {
      setState(() {
        userContactNumber = prefs.getString('mobile_number') ?? '';
        ownerId = prefs.getString('user_id') ?? '';
      });
    } else {
      prefs.setString('restaurant_id', id);
      Navigator.popAndPushNamed(context!, AppRoutes.pendingOnboarding);
    }
  }

  Future captureImage() async {
    final pickedFile =
    await _imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        uploadImage();
      } else {
        print('No image selected.');
      }
    });
    // return image;
  }
  Future uploadImage() async {
    if (_image == null) return;
    final fileName = basename(_image!.path);
    final destination = 'files/hotels/$fileName';


    try {
      final ref = firebase_storage.FirebaseStorage.instance
          .ref(destination)
          .child('file/');
      await ref.putFile(_image!);
      final String downloadUrl = await ref.getDownloadURL();
      setState(() {
        foodImage = downloadUrl;
      });

    } catch (e) {
      print('error occured');
    }
  }

  void registerHotel() {
    _registerHotelBloc.add(OnSubmitButtonClicked(
        id: ownerId,
        name: _nameController.text,
        phone: userContactNumber,
        restaurantMenuType: selectedCusineType,
        address: _addressController.text,
        landmark: _landmarkController.text,
        city: _cityController.text,
        state: selectedState,
        accountNumber: _accountNumberController.text,
        ifsc: _ifscController.text,
        upi: _upiIdController.text,
        image: foodImage,
        gstNumber: _gstController.text,
        gstPercent: double.parse(_gstPercentageController.text),
        lat: lat!,
        lng: lng!));
  }

}
