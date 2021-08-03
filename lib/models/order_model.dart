class OrderModel {
  final String orderId;

  final String state;
  final String dateCreated;
  // final List<Item> item;

  OrderModel(
      {required this.orderId,
    //  required this.item,
      required this.state,
      required this.dateCreated});
}

class Item {
  final String price;
  final String quantity;
  final String itemName;
  Item({
    required this.price,
    required this.quantity,
    required this.itemName,
  });
}
