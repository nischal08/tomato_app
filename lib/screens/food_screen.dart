import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tomato_app/contants/color_properties.dart';
import 'package:tomato_app/controller/food_controller.dart';

class FoodScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FoodController _foodStateController = Provider.of<FoodController>(context);
    return Container(
      child: FutureBuilder(
        future: _foodStateController.getFoodCategory(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 1,
              mainAxisSpacing: 1,
            ),
            itemCount: _foodStateController.categoryItems.length,
            itemBuilder: (context, index) {
              return GridTile(
                footer: Container(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  color: Theme.of(context).accentColor.withOpacity(0.1),
                  child: Text(_foodStateController.categoryItems[index].name,
                      textAlign: TextAlign.center),
                ),
                child: ClipRRect(
                  child: Image.network(
                      _foodStateController.categoryItems[index].image),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
