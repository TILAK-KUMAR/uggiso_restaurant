import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uggiso_restaurant/Bloc/AddNewFoodItemBloc/AddFoodBloc.dart';
import 'package:uggiso_restaurant/Bloc/AddNewFoodItemBloc/AddFoodEvent.dart';
import 'package:uggiso_restaurant/Bloc/AddNewFoodItemBloc/AddFoodState.dart';
import 'package:uggiso_restaurant/Model/AddFoodModel.dart';
import 'package:uggiso_restaurant/Widgets/ui-kit/RoundedContainer.dart';
import 'package:uggiso_restaurant/base/common/EditMenuArgs.dart';
import 'package:uggiso_restaurant/base/common/utils/colors.dart';
import 'package:uggiso_restaurant/base/common/utils/fonts.dart';
import '../app_routes.dart';
import '../base/common/utils/strings.dart';

class MenuTab extends StatefulWidget {
  const MenuTab({super.key});

  @override
  State<MenuTab> createState() => _MenuTabState();
}

class _MenuTabState extends State<MenuTab> {
  final AddFoodBloc _addFoodBloc = AddFoodBloc();
  String restId = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _addFoodBloc,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            goToAddMenuItemPage();
          },
          backgroundColor: AppColors.appPrimaryColor,
          child: const Icon(Icons.add),
        ),
        backgroundColor: AppColors.appPrimaryColor,
        appBar: AppBar(
          elevation: 0,
          title: Text(
            Strings.menu,
            style: AppFonts.appBarText.copyWith(color: AppColors.white),
          ),
          centerTitle: true,
          backgroundColor: AppColors.appPrimaryColor,
        ),
        body: BlocBuilder<AddFoodBloc, AddFoodState>(
          builder: (context, state) {
            if (state is LoadingState) {
              return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: AppColors.white,
                  child: Center(
                      child: CircularProgressIndicator(
                    color: AppColors.appPrimaryColor,
                  )));
            } else if (state is onLoadedState) {
              return state.menuList?.length == 0
                  ? Center(child: Text('No Items Found'))
                  : Padding(
                      padding: const EdgeInsets.only(top: 18.0),
                      child: Container(
                        padding: EdgeInsets.only(top: 20),
                        decoration: const BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(32),
                              topRight: Radius.circular(24)),
                        ),
                        width: double.infinity,
                        height: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                              itemCount: state.menuList?.length,
                              itemBuilder: (BuildContext context, int count) {
                                return MenuCard(state.menuList![count]);
                              }),
                        ),
                      ),
                    );
            } else if (state is ErrorState) {
              // Error state, display the error message
              return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: AppColors.white,
                  child: Center(child: Text('${state.message}')));
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  Widget MenuCard(Payload menuList) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                RoundedContainer(
                  width: MediaQuery.of(context).size.width * 0.2,
                  height: MediaQuery.of(context).size.height * 0.08,
                  cornerRadius: 24,
                  padding: 0,
                  borderColor: AppColors.white,
                  child: menuList.photo == null
                      ? Image.asset(
                          'assets/ic_no_image.png',
                        )
                      : Image.network(
                          menuList.photo.toString(),

                          errorBuilder: (BuildContext context, Object exception,
                              StackTrace? stackTrace) {
                            // Display a placeholder image or alternative content
                            return SizedBox(
                              width: MediaQuery.of(context).size.width * 0.2,
                              height: MediaQuery.of(context).size.height * 0.08,
                              child: Center(
                                child: Image.asset(
                                  'assets/ic_no_image.png',
                                ),
                              ),
                            );
                          },
                        ),
                ),
                SizedBox(
                  width: 12,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        menuList.menuName.toString(),
                        style: AppFonts.title,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        menuList.description.toString(),
                        style: AppFonts.smallText,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        "₹ ${menuList.price.toString()}",
                        style: AppFonts.title,
                      )
                    ],
                  ),
                ),
                SizedBox(width: 12),
                InkWell(
                    onTap: () {
                      print('this is clicked :${menuList}');
                      Navigator.pushNamed(context, AppRoutes.editMenuItem,arguments: EditMenuArgs(payload: menuList));

                    },
                    child: Image.asset(
                      'assets/ic_edit.png',
                      width: 20,
                      height: 20,
                      color: AppColors.appPrimaryColor,
                    )),
                SizedBox(width: 20),
                InkWell(
                    onTap: () {
                      _addFoodBloc.add(
                          onDeleteMenuItem(id: menuList.menuId.toString()));
                    },
                    child: Image.asset(
                      'assets/ic_delete.png',
                      width: 22,
                      height: 22,
                      color: Colors.red,
                    ))
              ],
            ),
            SizedBox(
              height: 12.0,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 2,
              color: AppColors.grey,
            )
          ],
        ),
      );

  void goToAddMenuItemPage() {
    Navigator.pushNamed(context, AppRoutes.addNewMenuItem);
  }

  void loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      restId = prefs.getString('restaurant_id') ?? '';
    });
    _addFoodBloc.add(LoadMenuList(id: restId));
  }
}
