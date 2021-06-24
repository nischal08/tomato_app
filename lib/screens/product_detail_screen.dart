import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tomato_app/contants/color_properties.dart';
import 'package:tomato_app/controller/home_controller.dart';
import 'package:tomato_app/controller/product_detail_controller.dart';
import 'package:tomato_app/screens/home.dart';
import 'package:tomato_app/widgets/each_product_box.dart';
import 'package:tomato_app/widgets/custom_icon_button.dart';
import 'package:tomato_app/widgets/buy_button.dart';

class ProductDetailScreen extends StatelessWidget {
  late ProductDetailController _prodDetailContr;
  late HomeController _homeContrstate;
  @override
  Widget build(BuildContext context) {
    _prodDetailContr = Provider.of<ProductDetailController>(context);
    _homeContrstate = Provider.of<HomeController>(context);
    return Scaffold(
      body: _body(context),
    );
  }

  Widget _body(context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          _titleInfo(context),
          SizedBox(
            height: 25,
          ),
          _ingredient(context),
          SizedBox(
            height: 40,
          ),
          _productInfoWithImg(context),
          Spacer(),
          _transactionBtn(context),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Widget _transactionBtn(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BuyButton(
            fgColor: kColorWhiteText,
            title: "Buy Now",
            bgColor: Theme.of(context).accentColor,
            onPressed: () async {
              await _homeContrstate.onBottomNavClick(2);
            },
          ),
          BuyButton(
              title: "Add To Cart",
              bgColor: Theme.of(context).primaryColorDark,
              onPressed: () async {
                await _homeContrstate.onBottomNavClick(2);
              }),
        ],
      ),
    );
  }

  Stack _productInfoWithImg(context) {
    return Stack(
      children: [
        _productInfo(context),
        Positioned(
          right: -80,
          child: Container(
            height: 320,
            child: Image.asset('assets/foods/polopizza.png'),
          ),
        ),
      ],
    );
  }

  Widget _productInfo(context) {
    return Container(
      padding: EdgeInsets.only(
        left: 30.0,
      ),
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _price(650, context),
          // SizedBox(
          //   height: 40.0,
          // ),
          // _eachProductInfo(
          //   key: "Calories",
          //   value: "750 Calories",
          // ),
          SizedBox(
            height: 30.0,
          ),
          _eachProductInfo(
            key: "Weight",
            value: "450 gm",
          ),
          SizedBox(
            height: 30.0,
          ),
          _eachProductInfo(
            key: "Delivery",
            value: "45 min",
          ),
          SizedBox(
            height: 40.0,
          ),
          _productQuantity(),
          SizedBox(
            height: 30,
          ),
          _productSizes(),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Widget _productSizes() {
    return Row(
      children: [
        for (String each in _prodDetailContr.productSizeList)
          Container(
            margin: EdgeInsets.only(right: 5),
            child: EachProductBox(
              isSelected: _prodDetailContr.currentProductSize ==
                  _prodDetailContr.productSizeList.indexOf(each),
              label: each,
              onPressed: () {
                _prodDetailContr.onProductSizeClick(
                  _prodDetailContr.productSizeList.indexOf(each),
                );
              },
            ),
          ),
      ],
    );
  }

  Widget _productQuantity() {
    return Row(
      children: [
        EachProductBox(
          icon: _prodDetailContr.prodQuantityList[0],
          onPressed: () {
            _prodDetailContr.onDecrQuantity();
          },
          isSelected: !_prodDetailContr.colorFlag,
        ),
        Container(
          height: 40,
          width: 38,
          alignment: Alignment.center,
          margin: EdgeInsets.only(right: 4),
          child: Text(
            _prodDetailContr.currentQuantity.toString(),
            style: GoogleFonts.robotoSlab(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        EachProductBox(
          icon: _prodDetailContr.prodQuantityList[1],
          onPressed: () {
            _prodDetailContr.onIncrQuantity();
          },
          isSelected: _prodDetailContr.colorFlag,
        ),
      ],
    );
  }

  Widget _eachProductInfo({
    required String key,
    required String value,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          key,
          style: GoogleFonts.robotoSlab(
            fontWeight: FontWeight.w500,
            fontSize: 15,
            color: Colors.black87.withOpacity(0.7),
          ),
        ),
        SizedBox(
          height: 8.0,
        ),
        Text(
          value,
          style: GoogleFonts.robotoSlab(
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _price(int price, context) {
    return Text(
      "Rs.$price",
      style: Theme.of(context).textTheme.headline6!.copyWith(
            fontWeight: FontWeight.w600,
            color: Theme.of(context).accentColor,
          ),
    );
  }

  Widget _ingredient(context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .65,
      child: Text(
        "Salami, chilli peppers, tomatoes, oregano, basil",
        textAlign: TextAlign.center,
        style: GoogleFonts.raleway(
          fontWeight: FontWeight.w500,
          fontSize: 17.5,
          color: Colors.black87.withOpacity(0.7),
        ),
      ),
    );
  }

  Widget _titleInfo(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 30.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomIconButton(
            paddingLeft: 9,
            icon: Icons.arrow_back_ios,
            onPressed: () {
              _homeContrstate.onChangeWidget(1);
            },
          ),
          _title(),
          CustomIconButton(
            onPressed: () async {
              await _homeContrstate.onBottomNavClick(2);
              Navigator.pushNamed(context, HomeScreen.routeName);
            },
            icon: Icons.shopping_bag_outlined,
          ),
        ],
      ),
    );
  }

  Widget _title() {
    return Text(
      "Pepperoni Pizza",
      style: GoogleFonts.raleway(
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
