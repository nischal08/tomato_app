import 'package:flutter/material.dart';
import 'package:tomato_app/contants/color_properties.dart';
import 'package:tomato_app/models/order_request.dart';

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

  void _confirmOrder() {
    if (_pickedLocation == null) {
      return;
    }

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Place Order'),
        backgroundColor: Theme.of(context).accentColor,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height -
            MediaQuery.of(context).padding.top -
            AppBar().preferredSize.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
               
                LocationInput(
                  onSelectPlace: _selectPlace,
                )
              ],
            ),
            Container(
              height: 55,
              margin: const EdgeInsets.only(bottom: 50),
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                  ),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Theme.of(context).accentColor),
                  elevation: MaterialStateProperty.all(0),
                  tapTargetSize: MaterialTapTargetSize
                      .shrinkWrap, //remove the large button to take less area remove padding
                ),
                onPressed: _confirmOrder,
                child: Text('Confirm Order',
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: kColorWhiteText)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
