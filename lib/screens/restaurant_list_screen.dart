import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tomato_app/contants/constant.dart';
import 'package:tomato_app/controller/auth.dart';
import 'package:tomato_app/controller/products.dart';
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

  @override
  void initState() {
    _getRestaurants(context);
    super.initState();
  }

  _getRestaurants(context) async {
    Provider.of<Auth>(context, listen: false).getUserInfo(context);

    await Provider.of<Restaurants>(context, listen: false)
        .getRestaurantList(context);
    Provider.of<Products>(context, listen: false).getCategory(context);
  }

  @override
  Widget build(BuildContext context) {
    _themeData = Theme.of(context).textTheme;
    _restaurants = Provider.of<Restaurants>(context);
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        Provider.of<Restaurants>(context, listen: false).ontoggleSearchbar();
      },
      child: Scaffold(
        // backgroundColor: Theme.of(context).canvasColor,
        appBar: AppBar(
          
          backgroundColor: Theme.of(context).canvasColor,
          elevation: 1,
          title:_greeting(context) ,

          actions: [
            Padding(
              padding: const EdgeInsets.only(right:10.0,),
              child: _popupMenu(context),
            )
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () => _getRestaurants(context),
          child: _body(
            context,
          ),
        ),
      ),
    );
  }

  Widget _carouselSlider() {
    return CarouselSlider(
      items: [
        Image.asset(
          "assets/venders/slider1.jpg",
        ),
        Image.asset("assets/venders/slider2.jpeg"),
        Image.asset("assets/venders/slider3.jpg"),
      ],
      options: CarouselOptions(
        height: 248,
        autoPlay: true,
        pageSnapping: true,
        viewportFraction: 1,
        autoPlayInterval: Duration(seconds: 3),
      ),
    );
  }

  Widget _body(
    context,
  ) {
    return SingleChildScrollView(
      child: Column(
        children: [
         
         
          _carouselSlider(),
          SizedBox(
            height: 20,
          ),
          _search(context),
          SizedBox(
            height: 10,
          ),
          _restaurants.showSpinner
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
        ],
      ),
    );
  }

  Widget _vender(context) {
    return Consumer<Restaurants>(
      builder: (__, Restaurants restaurants, _) => Column(
        // itemCount: restaurants.items.length,
        children: [
          for (rlModel.Datum restaurantData in restaurants.items)
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              margin: EdgeInsets.symmetric(vertical: 10),
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
            )
        ],
      ),
    );
  }

  _userGreetingAndMenus(context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _greeting(context),
          _popupMenu(context)
        ],
      ),
    );
  }

  PopupMenuButton<int> _popupMenu(context) {
    return PopupMenuButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              15,
            ),
          ),
          color: Theme.of(context).canvasColor,
          icon: Icon(Icons.more_horiz,color:Colors.black),
          iconSize: 32,
          elevation: 10,
          onSelected: (int value) async {
            if (value == 1) {
              print(Menus.logout);
              Provider.of<Auth>(context, listen: false).logoutUser(context);
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
        );
  }

  Widget _greeting(context) {
    return Consumer<Auth>(
      builder: (context, auth, __) => RichText(
        text: TextSpan(
          text: "Good Morning, ",
          style: _themeData.headline5!.copyWith(
            fontWeight: FontWeight.w600,
          ),
          children: [
            TextSpan(
              text: auth.userInfoResponse == null
                  ? "Loading..."
                  : auth.userInfoResponse!.data.firstname,
              style: _themeData.headline5!.copyWith(
                color: Theme.of(context).accentColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _search(context) {
    return Consumer<Restaurants>(
      builder: (context, resturantCont, _) => Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
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
          "Local Restaurants",
          style: _themeData.headline6!.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          "Nearby",
          style: _themeData.headline6!.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
