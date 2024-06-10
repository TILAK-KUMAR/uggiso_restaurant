import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uggiso_restaurant/Bloc/OrderBloc/OrderBloc.dart';
import 'package:uggiso_restaurant/Bloc/OrderBloc/OrderState.dart';
import 'package:uggiso_restaurant/Model/RestaurantOrderModel.dart';
import 'package:uggiso_restaurant/Widgets/ui-kit/RoundedContainer.dart';
import 'package:uggiso_restaurant/Widgets/ui-kit/RoundedElevatedButton.dart';
import '../Bloc/OrderBloc/OrderEvent.dart';
import '../base/common/utils/colors.dart';
import '../base/common/utils/fonts.dart';
import '../base/common/utils/strings.dart';

class OrdersTab extends StatefulWidget {
  const OrdersTab({super.key});

  @override
  State<OrdersTab> createState() => _OrdersTabState();
}

class _OrdersTabState extends State<OrdersTab> {
  final String _title = Strings.total_orders;
  final int _totalOrderPreparing = 0;
  String totalOrders = '';
  final int _totalOrderReady = 0;
  final int _totalOrderCompleted = 0;
  final OrderBloc _orderBloc = OrderBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRestaurantOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.textFieldBorderColor,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          '$_title ${totalOrders}',
          style: AppFonts.appBarText.copyWith(color: AppColors.white),
        ),
        leading: Container(),
        centerTitle: true,
        backgroundColor: AppColors.appPrimaryColor,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Image.asset(
              'assets/ic_notification.png',
              width: 20,
              height: 20,
            ),
          )
        ],
      ),
      body: BlocProvider(
        create: (context) => _orderBloc,
        child: Column(
          children: [
            HeaderWidget(),
            BlocBuilder<OrderBloc, OrderState>(builder: (context, state) {
              if (state is ErrorState) {
                return Expanded(
                    child: Center(
                  child: Text(
                    '${state.message}',
                    style: AppFonts.title,
                    textAlign: TextAlign.center,
                  ),
                ));
              } else if (state is onLoadedState) {
                totalOrders = state.data!.payload!.length.toString();
                return Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.data?.payload?.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          Container(
                              color: AppColors.white,
                              child: ItemCard(state.data!.payload![index])),
                          Gap(20),
                        ],
                      );
                    },
                  ),
                );
              }
              return const Expanded(
                  child: Center(
                child: Text(
                  'Something went wrong',
                  style: AppFonts.title,
                  textAlign: TextAlign.center,
                ),
              ));
            }),
          ],
        ),
      ),
    );
  }

  Widget ItemCard(Payload payload) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28.0),
      child: Container(
        //consdiitoona basis if count is more than 4 then height wil increase
        height: 260,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RoundedContainer(
                  width: 82,
                  height: 36,
                  cornerRadius: 5,
                  color: AppColors.appPrimaryColor,
                  child: Center(
                    child: Text(
                      'ID:${payload.orderId.toString().substring(0, 5)}',
                      style: AppFonts.title
                          .copyWith(color: AppColors.white, fontSize: 12),
                    ),
                  ),
                ),
                Text('${payload.orderTime}'),
              ],
            ),
            Gap(12),
            Column(
              children: List.generate(
                payload.menus!.length,
                (index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            WidgetSpan(
                                child: payload
                                            .menus?[index].restaurantMenuType ==
                                        null
                                    ? Container()
                                    : payload.menus?[index]
                                                .restaurantMenuType ==
                                            'VEG'
                                        ? Image.asset('assets/ic_veg.png',height: 12,
                                  width: 12,)
                                        : Image.asset('assets/ic_non_veg.png',height: 12,
                                  width: 12,)),
                            TextSpan(
                                text:
                                    " ${payload.menus?[index].quantity} x ${payload.menus?[index].menuName}",
                                style: AppFonts.smallText),
                          ],
                        ),
                      ),
                      Text(
                        '${payload.menus?[index].quantityAmount}',
                        style: AppFonts.smallText,
                      )
                    ],
                  );
                },
              ),
            ),
            Divider(),
            Text(
              'Description: Please make veg fired rice spicy',
              style: AppFonts.smallText.copyWith(fontSize: 10),
            ),
            Text(
              'Do not send cuttlery,tissues and straws',
              style: AppFonts.smallText.copyWith(
                fontSize: 10,
                color: Colors.red,
              ),
            ),
            Divider(),
            Gap(8),
            RoundedElevatedButton(
              width: double.infinity,
              height: 40,
              text: 'hello',
              onPressed: () {},
              cornerRadius: 5,
              buttonColor: AppColors.appPrimaryColor,
              textStyle: AppFonts.smallText,
            ),
          ],
        ),
      ),
    );
  }

  Widget HeaderWidget() => Container(
        height: MediaQuery.of(context).size.height * 0.11,
        decoration: const BoxDecoration(
          color: AppColors.appPrimaryColor,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(32),
              bottomRight: Radius.circular(24)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            RoundedContainer(
                color: AppColors.white,
                width: MediaQuery.of(context).size.width * 0.25,
                height: MediaQuery.of(context).size.height * 0.07,
                cornerRadius: 0,
                borderColor: AppColors.appPrimaryColor,
                child: Column(
                  children: [
                    Text(Strings.preparing,
                        style: AppFonts.title.copyWith(
                            color: AppColors.appPrimaryColor, fontSize: 12)),
                    Gap(4),
                    Text(_totalOrderPreparing.toString(),
                        style: AppFonts.subHeader.copyWith(
                            color: AppColors.appPrimaryColor, fontSize: 12)),
                  ],
                )),
            RoundedContainer(
                color: AppColors.white,
                width: MediaQuery.of(context).size.width * 0.28,
                height: MediaQuery.of(context).size.height * 0.07,
                cornerRadius: 0,
                borderColor: AppColors.appPrimaryColor,
                child: Column(
                  children: [
                    Text(Strings.ready,
                        style: AppFonts.title.copyWith(
                            color: AppColors.appPrimaryColor, fontSize: 12)),
                    Gap(4),
                    Text(_totalOrderReady.toString(),
                        style: AppFonts.subHeader.copyWith(
                            color: AppColors.appPrimaryColor, fontSize: 12)),
                  ],
                )),
            RoundedContainer(
                color: AppColors.white,
                width: MediaQuery.of(context).size.width * 0.28,
                height: MediaQuery.of(context).size.height * 0.07,
                borderColor: AppColors.appPrimaryColor,
                cornerRadius: 0,
                child: Column(
                  children: [
                    Text(Strings.completed,
                        style: AppFonts.title.copyWith(
                            color: AppColors.appPrimaryColor, fontSize: 12)),
                    Gap(4),
                    Text(_totalOrderCompleted.toString(),
                        style: AppFonts.subHeader.copyWith(
                            color: AppColors.appPrimaryColor, fontSize: 12)),
                  ],
                ))
          ],
        ),
      );

  void getRestaurantOrders() async {
    final prefs = await SharedPreferences.getInstance();
    String userId = '';
    userId = prefs.getString('restaurant_id') ?? '';
    _orderBloc.add(OnOrderReceived(id: userId));
  }
}
