import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:tomato_app/contants/color_properties.dart';
import 'package:tomato_app/controller/products.dart';
import 'package:tomato_app/controller/restaurants.dart';
import 'package:tomato_app/helper/directions_repository.dart';
import 'package:tomato_app/models/directions_model.dart';
import 'package:tomato_app/models/place_location.dart';
import 'package:tomato_app/models/product_list.dart';
import 'package:tomato_app/screens/map_screen.dart';
import 'package:tomato_app/widgets/product_card.dart';

class RestaurantMenu extends StatefulWidget {
  static const routeName = '/restaurant-menu';
  @override
  _RestaurantMenuState createState() => _RestaurantMenuState();
}

class _RestaurantMenuState extends State<RestaurantMenu> {
  bool isDirectionReady = true;
  bool isInit = false;
  bool isLoading = false;
  var _theme;
  late String restaurantId;
  late TextTheme _themeData;
  late PlaceLocation _venderPlaceLocation;
  LocationData? currentUserLocation;
  Directions? directions;
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    isLoading = true;
    restaurantId = ModalRoute.of(context)!.settings.arguments as String;
    if (!isInit) {
      _loadingData(context);
      await Provider.of<Restaurants>(context, listen: false)
          .getRestaurantInfo(context, id: restaurantId);
      Provider.of<Restaurants>(context, listen: false)
          .getRestaurantLocationName();

      _venderPlaceLocation = PlaceLocation(
        latitude: Provider.of<Restaurants>(context, listen: false)
            .restaurantInfoResponse!
            .data
            .address[0]
            .coordinates[1],
        longitude: Provider.of<Restaurants>(context, listen: false)
            .restaurantInfoResponse!
            .data
            .address[0]
            .coordinates[0],
      );
      currentUserLocation = await Location().getLocation();
      getUserDirection();

      print(
          "View on map + ${_venderPlaceLocation.latitude}  ${_venderPlaceLocation.longitude}");
    }
    isInit = true;
    isLoading = false;
  }

  Future<void> getUserDirection() async {

    
    directions = await DirectionsRepository().getDirections(
      origin: LatLng(
          currentUserLocation!.latitude!, currentUserLocation!.longitude!),
      destination:
          LatLng(_venderPlaceLocation.latitude, _venderPlaceLocation.longitude),
    );
    setState(() {
          isDirectionReady = false;
    });
    print("directions" + directions.toString());
  }

  _loadingData(context) async {
    await Provider.of<Products>(context, listen: false)
        .getRestaurantItems(context, restaurantId: restaurantId);
  }

  @override
  Widget build(BuildContext context) {
    _themeData = Theme.of(context).textTheme;
    _theme = Theme.of(context);
    final Products productData = Provider.of<Products>(context);
    return _body(context, productData);
  }

  Widget _body(context, productData) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              child: _backgroundImage(),
            ),
            Positioned(
              width: MediaQuery.of(context).size.width,
              top: 170,
              // left: 0,
              // right: 0,
              child: _infoBody(context, productData),
            )
          ],
        ),
      ),
    );
  }

  Widget _infoBody(context, productData) {
    return Container(
      height: MediaQuery.of(context).size.height - 170,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        color: Theme.of(context).canvasColor,
      ),
      child: RefreshIndicator(
        onRefresh: () => _loadingData(context),
        child: Column(
          children: [
            _venderInfo(),
            _deliveryInfoBanner(context),
            _productList(context, productData),
          ],
        ),
      ),
    );
  }

  Container _deliveryInfoBanner(context) {
    return Container(
            alignment: Alignment.center,
            height: 80,
            width: double.infinity,
            color: Colors.orange,
            margin: EdgeInsets.only(bottom: 20),
            padding: EdgeInsets.symmetric(horizontal: 50),
            child: Text(
              "This Restaurant is Currently Open for Delivery",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline6,
            ),
          );
  }

  Widget _backgroundImage() {
    return Stack(
      children: [
        ColorFiltered(
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.4),
            BlendMode.darken,
          ),
          child: 
            Image.asset(
              "assets/foods/restaurant-foods.jpg",
            ),
         
        ),
        SafeArea(
          child: _customAppbar(),
        ),
      ],
    );
  }

  Widget _productList(context, Products productData) {
    return Container(
      child: productData.showSpinner
          ? Center(
              child: CircularProgressIndicator(),
            )
          : productData.restaurantMenuItems.isEmpty
              ? Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.60,
                    child: Text(
                      "This restaurant is coming soon!!",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                )
              : Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      // itemCount: productData.restaurantMenuItems.length,
                      children: [
                        for (Datum menuItems in productData.restaurantMenuItems)
                          ChangeNotifierProvider<Datum>.value(
                            value: menuItems,
                            child: ProductCard(context),
                          ),
                        SizedBox(
                          height: 60,
                        )
                      ],
                    ),
                  ),
                ),
    );
  }

  _customAppbar() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title(),
          _backBtn(),
        ],
      ),
    );
  }

  GestureDetector _backBtn() {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
        // return _homeControllerState.onChangeWidget(0);
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Icon(
          Icons.arrow_back_ios,
          size: 30,
          color: Colors.white,
        ),
      ),
    );
  }

  _title() {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Choose what you",
              style: _themeData.headline4!.copyWith(
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "want to eat today",
              style: _themeData.headline5!.copyWith(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _venderInfo() {
    return Consumer<Restaurants>(
      builder: (__, restaurants, _) => Container(
        padding: EdgeInsets.only(bottom: 10, left: 20, right: 20, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // _venderLogo(restaurants),
                _venderName(restaurants),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      borderRadius: BorderRadius.circular(8)),
                  child: Text(
                    "4.2",
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        color: kColorWhiteText, fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 6,
            ),
            Text(
              restaurants.restaurantLocation == null
                  ? "Loading..."
                  : restaurants.restaurantLocation!,
              style: Theme.of(context).textTheme.subtitle2!.copyWith(
                  fontWeight: FontWeight.w400, color: Colors.grey.shade800),
            ),
            SizedBox(
              height: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Opens at 9:30 am",
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      fontWeight: FontWeight.w400, color: Colors.grey.shade800),
                ),
                if(!isDirectionReady) TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        fullscreenDialog: true,
                        builder: (context) => MapScreen(
                          userLocationData: currentUserLocation,
                          isSelecting: false,
                          initialLocation: _venderPlaceLocation,
                          direction: directions,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    "View on Maps",
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).accentColor),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _venderName(Restaurants restaurants) {
    return Text(
      restaurants.restaurantInfoResponse == null
          ? "Loading..."
          : restaurants.restaurantInfoResponse!.data.name,
      style: _themeData.headline5!.copyWith(fontWeight: FontWeight.bold),
    );
  }
}
