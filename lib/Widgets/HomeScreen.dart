import 'package:flutter/material.dart';
import 'package:uggiso_restaurant/Widgets/MenuTab.dart';
import 'package:uggiso_restaurant/Widgets/OrdersTab.dart';
import 'package:uggiso_restaurant/Widgets/PaymentsTab.dart';

import '../base/common/utils/colors.dart';
import '../base/common/utils/strings.dart';
import 'ProfileTab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static const List _imagePaths = [
    'assets/ic_fire.png',
    'assets/ic_menu.png',
    'assets/ic_payment.png',
    'assets/ic_person.png',
  ];

  final List<String> text = [
    Strings.orders,
    Strings.menu,
    Strings.payments,
    Strings.profile,
  ];

  static List<Widget> _widgetOptions = <Widget>[
    OrdersTab(),
    MenuTab(),
    PaymentsTab(),
    ProfileTab(),

  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),

      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Container(
          height: 70,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(_imagePaths.length, (index) {
                return buildNavBarItem(index);
              }),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildNavBarItem(int index) {
    return InkWell(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Image.asset(_imagePaths[index], height: 24, width: 24,
            color: _selectedIndex == index
                ? AppColors.appPrimaryColor
                : AppColors.bottomTabInactiveColor,
          ),
          SizedBox(height: 4.0,),
          /*Icon(
            icons[index],
            color: _selectedIndex == index ? AppColors.appPrimaryColor : AppColors.bottomTabInactiveColor,
          ),*/
          Text(
            text[index],
            style: TextStyle(
              fontSize: 12,
              color: _selectedIndex == index
                  ? AppColors.appPrimaryColor
                  : AppColors.bottomTabInactiveColor,
            ),
          ),
        ],
      ),
    );
  }
}
