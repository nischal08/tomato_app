import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tomato_app/controller/food_controller.dart';

class FoodScreen extends StatelessWidget {
  static const routeName = "/food-category";
  @override
  Widget build(BuildContext context) {
    FoodController _foodStateController = Provider.of<FoodController>(
      context,
      listen: false,
    );
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          SafeArea(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.60,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Food at your service ",
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Any food you like ",
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          color: Theme.of(context).accentColor,
                        ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              constraints: BoxConstraints(
                minWidth: MediaQuery.of(context).size.width * 0.45,
                maxWidth: MediaQuery.of(context).size.width * 0.90,
              ),
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
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 30,
                    ),
                    itemCount: _foodStateController.categoryItems.length,
                    itemBuilder: (context, index) {
                      return GridTile(
                        footer: Container(
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).primaryColor.withOpacity(0.4),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Text(
                            _foodStateController.categoryItems[index].title,
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                        child: Container(
                          child: Image.network(
                            _foodStateController.categoryItems[index].image,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
