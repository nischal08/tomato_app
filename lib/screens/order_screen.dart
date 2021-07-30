import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tomato_app/controller/carts.dart';

class OrderScreen extends StatefulWidget {
  static const routeName = "/orders";
  const OrderScreen({Key? key}) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  void initState() {
    _loadingOrderData(context);
    super.initState();
  }

  _loadingOrderData(context) async {
    await Provider.of<Carts>(context, listen: false).fetchOrders(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Orders"),
      ),
      body: Consumer<Carts>(
        builder: (_, order, __) => order.showOrderSpinner
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
              color: Colors.green,
              child: Column(
                  children: [
                    for (var item in order.orderItems) Text(item.id,style: TextStyle(color:  Colors.black),),
                  ],
                ),
            ),
      ),
    );
  }
}
