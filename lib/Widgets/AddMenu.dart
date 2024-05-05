import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uggiso_restaurant/Bloc/AddNewFoodItemBloc/AddFoodBloc.dart';
import 'package:uggiso_restaurant/Bloc/AddNewFoodItemBloc/AddFoodEvent.dart';
import 'package:uggiso_restaurant/Bloc/AddNewFoodItemBloc/AddFoodState.dart';
import 'package:uggiso_restaurant/Widgets/ui-kit/AppBarBackIcon.dart';
import 'package:uggiso_restaurant/Widgets/ui-kit/ImageTitle.dart';
import 'package:uggiso_restaurant/Widgets/ui-kit/RoundedContainer.dart';
import 'package:uggiso_restaurant/Widgets/ui-kit/RoundedElevatedButton.dart';
import 'package:uggiso_restaurant/Widgets/ui-kit/TextFieldCurvedEdges.dart';
import 'package:uggiso_restaurant/base/common/utils/colors.dart';
import 'package:uggiso_restaurant/base/common/utils/fonts.dart';
import 'package:uggiso_restaurant/base/common/utils/strings.dart';

class AddMenu extends StatefulWidget {
  const AddMenu({super.key});

  @override
  State<AddMenu> createState() => _AddMenuState();
}

class _AddMenuState extends State<AddMenu> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController platesController = TextEditingController();
  final AddFoodBloc _addFoodBloc = AddFoodBloc();
  TextInputType string = TextInputType.text;
  TextInputType number = TextInputType.number;
  File? _image = null;
  final picker = ImagePicker();
  String foodType = 'VEG';
  bool isFoodTypeClickedVeg = false;
  bool isFoodTypeClickedNonVeg = false;
  String restaurantId = '';
  String foodImage = '';

  @override
  void initState() {
    getRestaurantid();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _addFoodBloc,
      child: BlocListener<AddFoodBloc, AddFoodState>(
        listener: (BuildContext context, AddFoodState state) {
          if (state is onLoadedState) {
            Navigator.pop(context);
          } else if (state is ErrorState) {}
        },
        child: Scaffold(
          backgroundColor: AppColors.appPrimaryColor,
          appBar: AppBar(
            backgroundColor: AppColors.appPrimaryColor,
            elevation: 0,
            leading: IconButton(
              icon: AppBarBackIcon(), // Use a custom icon for back
              onPressed: () {
                Navigator.pop(context); // You can customize the action here
              },
            ),
            title: Text(Strings.menu_details),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 18.0),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(24)),
              ),
              width: double.infinity,
              height: double.infinity,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      UploadPicture(),
                      SizedBox(
                        height: 12,
                      ),
                      TitleDiscriptionWidget(
                          Strings.dish_title, titleController, string, false),
                      TitleDiscriptionWidget(Strings.dish_discription,
                          descriptionController, string, true),
                      TitleDiscriptionWidget(
                          Strings.price, priceController, number, false),
                      TitleDiscriptionWidget(Strings.preparing_time,
                          timeController, number, false),
                      TitleDiscriptionWidget(Strings.number_of_serves,
                          platesController, number, false),
                      Text(
                        Strings.options,
                        style: AppFonts.smallText.copyWith(fontSize: 16),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              if (isFoodTypeClickedVeg == false)
                                setState(() {
                                  isFoodTypeClickedVeg = true;
                                  isFoodTypeClickedNonVeg = false;
                                });
                            },
                            child: RoundedContainer(
                                width: MediaQuery.of(context).size.width * 0.2,
                                height:
                                    MediaQuery.of(context).size.height * 0.04,
                                color: isFoodTypeClickedVeg
                                    ? AppColors.grey
                                    : AppColors.white,
                                child: ImageTitle(
                                    image: 'assets/ic_veg.png', title: 'Veg'),
                                cornerRadius: 40),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.1,
                          ),
                          InkWell(
                            onTap: () {
                              if (isFoodTypeClickedNonVeg == false)
                                setState(() {
                                  isFoodTypeClickedVeg = false;
                                  isFoodTypeClickedNonVeg = true;
                                });
                            },
                            child: RoundedContainer(
                                width: MediaQuery.of(context).size.width * 0.2,
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                color: isFoodTypeClickedNonVeg
                                    ? AppColors.grey
                                    : AppColors.white,
                                child: ImageTitle(
                                    image: 'assets/ic_non_veg.png',
                                    title: 'Non Veg'),
                                cornerRadius: 40),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Container(
                        alignment: Alignment.bottomCenter,
                        padding: const EdgeInsets.only(bottom: 30),
                        child: RoundedElevatedButton(
                            width: MediaQuery.of(context).size.width * 0.5,
                            height: 40.0,
                            text: Strings.done,
                            onPressed: () {
                              addData();
                            },
                            cornerRadius: 6.0,
                            buttonColor: AppColors.appPrimaryColor,
                            textStyle: AppFonts.header
                                .copyWith(color: AppColors.white)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget UploadPicture() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            Strings.upload_picture,
            style: AppFonts.smallText.copyWith(fontSize: 16),
          ),
          InkWell(
            onTap: () => captureImage(ImageSource.gallery),
            child: RoundedContainer(
                width: MediaQuery.of(context).size.width * 0.2,
                height: MediaQuery.of(context).size.height * 0.1,
                cornerRadius: 20,
                borderColor: AppColors.white,
                padding: 0,
                child: _image == null
                    ? Image.asset('assets/ic_upload_picture.png')
                    : Image.file(
                        _image!,
                        alignment: Alignment.center,
                        fit: BoxFit.fill,
                      )),
          ),
        ],
      );

  Widget TitleDiscriptionWidget(String title, TextEditingController controller,
          TextInputType inputType, bool isMultiLines) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppFonts.smallText.copyWith(fontSize: 16),
          ),
          SizedBox(
            height: 8,
          ),
          TextFieldCurvedEdges(
              controller: controller,
              backgroundColor: AppColors.white,
              keyboardType: inputType,
              borderRadius: 4,
              maxLines: isMultiLines ? 4 : 1,
              length: isMultiLines ? 1000 : 100,
              borderColor: AppColors.textFieldBorderColor),
          SizedBox(
            height: 8,
          ),
        ],
      );

  Future captureImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        uploadImage();
      } else {
        print('No image selected.');
      }
    });
  }

  Future uploadImage() async {
    List<int> imageBytes = _image!.readAsBytesSync();
    String base64Image = await base64Encode(imageBytes);
    setState(() {
      foodImage = "base64Image";
    });
  }

  void addData(){
    _addFoodBloc.add(OnSubmitButtonClicked(
      id: '51f6e514-80ab-466f-9ccc-916d80850c4d',
      title: titleController.text,
      description: descriptionController.text,
      menuType:'MEALS',
      foodType: isFoodTypeClickedVeg?'VEG':'NONVEG',
      price: priceController.text,
      url: foodImage
    ));
  }

  void getRestaurantid() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      restaurantId = prefs.getString('restaurant_id') ?? '';
    });
  }
}
