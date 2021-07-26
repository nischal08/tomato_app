import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tomato_app/contants/color_properties.dart';
import 'package:tomato_app/controller/carts.dart';
import 'package:tomato_app/models/cart.dart';
import 'package:tomato_app/models/order_request.dart';
import 'package:tomato_app/widgets/general_elevated_button.dart';
import 'package:tomato_app/widgets/reusable_widget.dart';

import '../widgets/location_input.dart';

class ConfirmOrderScreen extends StatefulWidget {
  static const routeName = '/add-place';

  @override
  _ConfirmOrderScreenState createState() => _ConfirmOrderScreenState();
}

class _ConfirmOrderScreenState extends State<ConfirmOrderScreen> {
  Address? _pickedLocation;

  void _selectPlace(double lat, double lon) {
    _pickedLocation = Address(coordinates: [lat, lon], type: "Point");
    print(_pickedLocation!.coordinates[0]);
  }

  void _confirmOrder() async {
    if (_pickedLocation == null) {
      generalAlertDialog(context, "Please choose location");
      return;
    }
    await Provider.of<Carts>(context, listen: false).createOrders(
      context,
      cooridinate: LatLng(
        _pickedLocation!.coordinates[0],
        _pickedLocation!.coordinates[1],
      ),
    );

    Navigator.of(context).pop();
    // Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Provider.of<Carts>(
      context,
    ).showOrderSpinner
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(color: kColorBlackText),
              title: Text(
                'Place Order',
                style: Theme.of(context).textTheme.headline6,
              ),
              backgroundColor: Theme.of(context).canvasColor,
              elevation: 0.4,
              shadowColor: Colors.grey,
            ),
            body: Container(
              height: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top -
                  AppBar().preferredSize.height -
                  kBottomNavigationBarHeight,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Column(
                      children: [
                        LocationInput(
                          onSelectPlace: _selectPlace,
                        ),
                        Divider(
                          height: 1,
                          color: Colors.grey.shade400,
                          thickness: 1,
                          endIndent: 20,
                          indent: 20,
                        ),
                        _pickupTime(context),
                        _itemsInfo(context),
                        _productAmountInfo(context),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                    _confirmOrderBtn(context),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
            ),
          );
  }

  Consumer _productAmountInfo(BuildContext context) {
    return Consumer<Carts>(
      builder: (__, value, _) => Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        height: 160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300),
          color: Theme.of(context).cardColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _eachPriceItem(context,
                key: "Subtotal", value: value.totalAmount.toString()),
            _eachPriceItem(context, key: "Delivery Charge", value: "100"),
            _eachPriceItem(context,
                key: "Total", value: (value.totalAmount + 100).toString()),
          ],
        ),
      ),
    );
  }

  Column _eachPriceItem(BuildContext context,
      {required String key, required String value}) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                key,
                style: Theme.of(context).textTheme.headline6,
              ),
              Text(
                "Rs. $value",
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      color: Theme.of(context).accentColor,
                    ),
              ),
            ],
          ),
        ),
        Divider(
          height: 0,
        )
      ],
    );
  }

  Container _itemsInfo(BuildContext context) {
    return Container(
      height: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
        color: Theme.of(context).cardColor,
      ),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      width: double.infinity,
      child: Column(
        children: [
          _totalItem(context),
          Expanded(child: _itemDetailList()),
        ],
      ),
    );
  }

  Consumer _itemDetailList() {
    return Consumer<Carts>(
      builder: (__, Carts _restaurant, _) => Container(
        padding: EdgeInsets.only(top: 5, bottom: 10, left: 10, right: 10),
        child: ListView.builder(
          itemCount: _restaurant.cartItems.length,
          itemBuilder: (context, index) =>
              _item(context, value: _restaurant.cartItems[index]),
        ),
      ),
    );
  }

  Container _item(BuildContext context, {required Cart value}) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${value.title} x ${value.quantity}",
                  style: Theme.of(context).textTheme.headline6,
                ),
                Text(
                  "Rs.${value.totalPrice}",
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                        color: Theme.of(context).accentColor,
                      ),
                ),
              ],
            ),
          ),
          Divider()
        ],
      ),
    );
  }

  Container _totalItem(BuildContext context) {
    return Container(
      clipBehavior: Clip.none,
      padding: EdgeInsets.symmetric(horizontal: 10),
      height: 40,
      alignment: Alignment.centerLeft,
      child: Text(
        "2 items",
        // textAlign: TextAlign.start,
        style: Theme.of(context).textTheme.subtitle1!.copyWith(
              color: Theme.of(context).accentColor,
            ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
        color: Colors.grey.shade100,
      ),
    );
  }

  Container _confirmOrderBtn(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      height: 55,
      child: GeneralElevatedButton(
        title: "Confirm Order",
        bgColor: Theme.of(context).accentColor,
        onPressed: _confirmOrder,
      ),
    );
  }

  Container _pickupTime(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
        color: Theme.of(context).cardColor,
      ),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: EdgeInsets.all(10),
      width: double.infinity,
      child: Text(
        "Pick up will be ready at 5:19 PM",
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }
}
