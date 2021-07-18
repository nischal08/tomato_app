import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tomato_app/contants/constant.dart';
import 'package:tomato_app/controller/home_controller.dart';
import 'package:tomato_app/controller/restaurants.dart';
import 'package:tomato_app/models/restaurant_list_model.dart' as rlModel;
import 'package:tomato_app/screens/restaurant_menu.dart';
import 'package:tomato_app/widgets/custom_icon_button.dart';

import '../widgets/restaurant_card.dart';

// ignore: must_be_immutable
enum Menus { logout, profile }

class RestaurantListScreen extends StatefulWidget {
  static const routeName = '/restaurant-list';

  @override
  _RestaurantListScreenState createState() => _RestaurantListScreenState();
}

class _RestaurantListScreenState extends State<RestaurantListScreen> {
  late TextTheme _themeData;

  late Restaurants _restaurants;

  late HomeController _homeControllerState;
  String? userFirstname;
  @override
  void initState() {
    _getRestaurants(context);
    super.initState();
  }

  _getRestaurants(context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userFirstname = preferences.getString("userFirstname");
    await Provider.of<Restaurants>(context, listen: false)
        .getRestaurantList(context);
  }

  @override
  Widget build(BuildContext context) {
    _themeData = Theme.of(context).textTheme;
    _homeControllerState = Provider.of<HomeController>(context);
    _restaurants = Provider.of<Restaurants>(context);
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        Provider.of<Restaurants>(context, listen: false).ontoggleSearchbar();
      },
      child: Scaffold(
        // backgroundColor: Theme.of(context).canvasColor,
        body: _body(
          context,
        ),
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
            _userGreetingAndMenus(context),
            SizedBox(
              height: 25,
            ),
            _search(context),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: _restaurants.showSpinner
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : _restaurants.items.isEmpty
                      ? Container(
                          width: MediaQuery.of(context).size.width * 0.60,
                          child: Text(
                            "This restaurants is coming soon!!",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headline5,
                          ),
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
              margin: EdgeInsets.symmetric(vertical: 6),
              child: InkWell(
                onTap: () {
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

  _userGreetingAndMenus(context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 30,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _greeting(context),
          PopupMenuButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                15,
              ),
            ),
            color: Theme.of(context).canvasColor,
            icon: Icon(Icons.more_horiz),
            iconSize: 32,
            elevation: 10,
            onSelected: (int value) async {
              if (value == 1) {
                print(Menus.logout);
                SharedPreferences sharedPreferences =
                    await SharedPreferences.getInstance();
                sharedPreferences.remove("accessToken");
                sharedPreferences.remove("refreshToken");
                sharedPreferences.remove("userFirstName");
                sharedPreferences.remove("userId");
              } else {
                print(Menus.profile);
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text("Logout"),
                value: 1,
              ),
              PopupMenuItem(
                child: Text("Profile"),
                value: 2,
              )
            ],
          )
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
            text: userFirstname,
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

  Widget _searchBar(context) {
    return Container(
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Colors.white,
        child: TextField(
          decoration: kSearchBarDecoration,
          onChanged: (word) {
            Provider.of<Restaurants>(context, listen: false)
                .getRestaurantList(context, searchWord: word);
          },
          onSubmitted: (word) {
            Provider.of<Restaurants>(context, listen: false)
                .getRestaurantList(context, searchWord: word);
          },
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
          style: _themeData.headline5!.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          "favourite foods",
          style: _themeData.headline6!.copyWith(
            fontWeight: FontWeight.w100,
          ),
        ),
      ],
    );
  }
}
