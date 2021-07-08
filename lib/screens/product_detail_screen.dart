import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tomato_app/contants/color_properties.dart';
import 'package:tomato_app/controller/carts.dart';
import 'package:tomato_app/controller/home_controller.dart';
import 'package:tomato_app/controller/product_detail_controller.dart';
import 'package:tomato_app/models/product.dart';
import 'package:tomato_app/widgets/each_product_box.dart';
import 'package:tomato_app/widgets/custom_icon_button.dart';
import 'package:tomato_app/widgets/circular_button.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail';
  late ProductDetailController _prodDetailContr;
   late HomeController _homeCtrlrstate;

  late Product product;

  bool _checkBigDeviceSize(context) {
    return MediaQuery.of(context).size.height > 500 ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    product = ModalRoute.of(context)!.settings.arguments as Product;
    _prodDetailContr = Provider.of<ProductDetailController>(context);
    _homeCtrlrstate = Provider.of<HomeController>(context);
    return Scaffold(
      body: _body(context),
    );
  }

  Widget _body(context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            _upperContainer(context),
            Expanded(child: _lowerContainer(context)),
          ],
        ),
      ),
    );
  }

  Widget _lowerContainer(context) {
    return Container(
      // height: MediaQuery.of(context).size.height*0.60-MediaQuery.of(context).padding.bottom-kBottomNavigationBarHeight,
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      decoration: BoxDecoration(
          // borderRadius: BorderRadius.only(
          //   topLeft: Radius.circular(40),
          //   topRight: Radius.circular(40),
          // ),
          color: Theme.of(context).cardColor),
      child: Column(
        children: [
          _title(),
          Expanded(
            child: ListView(
              children: [
                _ingredient(context),
                SizedBox(height: 20),
                _productInfoRow(context),
                SizedBox(
                  height: 20,
                ),
                _venderInfo(context),
                SizedBox(
                  height: 20,
                ),
                _transactionBtn(context),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _venderInfo(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Theme.of(context).primaryColor,
              ),
              child: Image.asset(
                'assets/venders/kfc-chicken.png',
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Chin Club",
                  style: Theme.of(context).textTheme.subtitle2!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
                Text(
                  '3.1 km from you',
                  style: Theme.of(context).textTheme.subtitle2!.copyWith(
                        color: Colors.black54,
                        fontWeight: FontWeight.w400,
                      ),
                ),
              ],
            )
          ],
        ),
        Container(
          child: Row(
            children: [
              for (var i = 0; i < 5; i++)
                Icon(
                  Icons.star_rounded,
                  size: 16,
                  color: KColorRatingColor,
                )
            ],
          ),
        ),
      ],
    );
  }

  Widget _upperContainer(context) {
    return Container(
      child: Column(
        children: [
          Stack(
            children: [
              _productImage(context),
              Container(
                height: _checkBigDeviceSize(context) ? 345 : 295,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _appbarAction(context),
                    _productQuantity(),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _productInfoRow(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _eachProductInfo(
          context,
          key: "Delivery",
          value: "45 min",
        ),
        _eachProductInfo(
          context,
          key: "Price",
          value: "Rs.${product.price.toStringAsFixed(0)} ",
        ),
        _eachProductInfo(
          context,
          key: "Rating",
          value: "${product.rating}",
        ),
      ],
    );
  }

  Widget _productImage(context) {
    return Image.network(
      product.image,
      height: _checkBigDeviceSize(context) ? 350 : 250,
      fit: BoxFit.cover,
      width: double.infinity,
    );
  }

  Widget _transactionBtn(context) {
    return Row(
      children: [
        Expanded(
          child: CircularButton(
            fgColor: kColorWhiteText,
            title: "Buy Now",
            bgColor: Theme.of(context).accentColor,
            onPressed: () {
              // await _homeContrstate.onBottomNavClick(2);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Buying process is not available now."),
                ),
              );
            },
          ),
        ),
        SizedBox(
          width: 15,
        ),
        Expanded(
          child: CircularButton(
            title: "Add To Cart",
            bgColor: Theme.of(context).primaryColorDark,
            onPressed: () {
              // await _homeContrstate.onBottomNavClick(2);
              Provider.of<Carts>(context, listen: false).addCartItem(
                  product: product, quantity: _prodDetailContr.currentQuantity);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("${product.title} is added to cart."),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _productQuantity() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () => _prodDetailContr.onDecrQuantity(),
          icon: Icon(
            Icons.remove,
            color: Colors.white,
          ),
        ),
        EachProductBox(
          label: _prodDetailContr.currentQuantity.toString(),
          onPressed: () {},
        ),
        IconButton(
          onPressed: () => _prodDetailContr.onIncrQuantity(),
          icon: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _eachProductInfo(
    context, {
    required String key,
    required String value,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          key,
          style: Theme.of(context).textTheme.headline6,
        ),
        SizedBox(
          height: 8.0,
        ),
        Text(
          value,
          style: GoogleFonts.robotoSlab(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: Theme.of(context).accentColor,
          ),
        ),
      ],
    );
  }

  // Widget _price(int price, context) {
  //   return Text(
  //     "Rs.$price",
  //     style: GoogleFonts.lato(
  //       fontSize: 22,
  //       color: Theme.of(context).accentColor,
  //       fontWeight: FontWeight.w600,
  //     ),
  //   );
  // }

  Widget _ingredient(context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Ingredients",
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            "Salami, chilli peppers, tomatoes, oregano, basil",
            textAlign: TextAlign.center,
            style: GoogleFonts.raleway(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: Colors.black87.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _appbarAction(context) {
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.only(
        left: 30.0,
        
        top: 10,
      ),
      child: CustomIconButton(
        paddingLeft: 9,
        icon: Icons.arrow_back_ios,
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

  Widget _title() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Text(
        product.title,
        style: GoogleFonts.raleway(
          fontSize: 22,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
