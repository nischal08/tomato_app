import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tomato_app/contants/color_properties.dart';
import 'package:tomato_app/controller/home_controller.dart';
import 'package:tomato_app/controller/restaurants.dart';
import 'package:tomato_app/models/restaurant_list_model.dart' as rlModel;
import 'package:tomato_app/screens/restaurant_menu.dart';
import 'package:tomato_app/widgets/custom_icon_button.dart';

import '../widgets/restaurant_card.dart';

// ignore: must_be_immutable
class RestaurantListScreen extends StatefulWidget {
  static const routeName = '/restaurant-list';

  @override
  _RestaurantListScreenState createState() => _RestaurantListScreenState();
}

class _RestaurantListScreenState extends State<RestaurantListScreen> {
  late TextTheme _themeData;

  late Restaurants _restaurants;

  late HomeController _homeControllerState;

  @override
  void initState() {
    _getRestaurants(context);
    super.initState();
  }

  _getRestaurants(context) async {
    await Provider.of<Restaurants>(context, listen: false)
        .getRestaurantList(context);
  }

  @override
  Widget build(BuildContext context) {
    _themeData = Theme.of(context).textTheme;
    _homeControllerState = Provider.of<HomeController>(context);
    _restaurants = Provider.of<Restaurants>(context);
    return Scaffold(
      // backgroundColor: Theme.of(context).canvasColor,
      body: _body(
        context,
      ),
    );
  }

  Widget _body(
    context,
  ) {
    return SafeArea(
      child: Container(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            _userInfo(context),
            SizedBox(
              height: 25,
            ),
            _search(context),
            SizedBox(
              height: 20,
            ),
            // _category(
            //   context,
            // ),
            // SizedBox(
            //   height: 15,
            // ),
            Expanded(
              child: _restaurants.items.isEmpty
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : _vender(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _vender(context) {
    return Consumer<Restaurants>(
      builder: (__, Restaurants restaurants, _) => RefreshIndicator(
        onRefresh: () => _getRestaurants(context),
        child: ListView.builder(
          itemCount: restaurants.items.length,
          itemBuilder: (context, index) {
            rlModel.Datum restaurantData = restaurants.items[index];
            return Container(
              padding: EdgeInsets.symmetric(
                horizontal: 30,
              ),
              margin: EdgeInsets.symmetric(vertical: 10),
              child: InkWell(
                onTap: () {
                  // _homeControllerState.onChangeWidget(1);
                  Navigator.pushNamed(
                    context,
                    RestaurantMenu.routeName,
                    arguments: restaurantData.id,
                  );
                },
                child: RestaurantCard(
                  networkUrl: restaurantData.image.isEmpty
                      ? null
                      : restaurantData.image[0],
                  title: restaurantData.name,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  _userInfo(context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 30,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _greeting(context),
          _userProfileImg(),
        ],
      ),
    );
  }

  _userProfileImg() {
    return Container(
      height: 45,
      width: 45,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Image.network(
          _restaurants.userImgUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _greeting(context) {
    return RichText(
      text: TextSpan(
        text: "Good Morning, ",
        style: _themeData.headline6,
        children: [
          TextSpan(
            text: "Nischal",
            style: _themeData.headline6!
                .copyWith(color: Theme.of(context).primaryColor),
          ),
        ],
      ),
    );
  }

  _search(context) {
    return Consumer<Restaurants>(
      builder: (context, resturantCont, _) => Container(
        height: 50,
        padding: EdgeInsets.symmetric(
          horizontal: 30,
        ),
        child: resturantCont.toggleSearchbar
            ? _searchBar(context)
            : _searchButtonTitle(),
      ),
    );
  }

  Widget _searchButtonTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _searchTitle(),
        CustomIconButton(
          elevation: 1,
          icon: Icons.search,
          onPressed: () => _restaurants.ontoggleSearchbar(),
        )
      ],
    );
  }

  TextField _searchBar(context) {
    return TextField(
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        hintText: "Search",
        contentPadding: EdgeInsets.only(top: 5),
        hintStyle: TextStyle(
          color: kColorLightGrey,
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Icon(Icons.search),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: kColorLightGrey!,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide:
              BorderSide(color: kColorLightGrey!.withOpacity(0.8), width: 1),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide:
              BorderSide(color: Theme.of(context).accentColor, width: 1.2),
        ),
      ),
    );
  }

  _searchTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Find your",
          style: _themeData.headline6!.copyWith(fontWeight: FontWeight.w500),
        ),
        Text(
          "favourite foods",
          style: _themeData.subtitle1!.copyWith(fontWeight: FontWeight.w100),
        ),
      ],
    );
  }
}
