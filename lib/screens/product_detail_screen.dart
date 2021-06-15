import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tomato_app/contants/color_properties.dart';
import 'package:tomato_app/controller/homeController.dart';
import 'package:tomato_app/controller/productDetailController.dart';
import 'package:tomato_app/screens/home.dart';
import 'package:tomato_app/widgets/EachProductBox.dart';
import 'package:tomato_app/widgets/custom_icon_button.dart';
import 'package:tomato_app/widgets/custom_widgets.dart';
import 'package:tomato_app/widgets/general_text_button.dart';

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
          _titleInfo(),
          SizedBox(
            height: 25,
          ),
          _ingredient(),
          SizedBox(
            height: 40,
          ),
          _productInfoWithImg(),
          SizedBox(
            height: 25,
          ),
          _transactionBtn(context),
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


          BuyAndAddToCartButton( 
          fgColor: Colors.black,
            title: "Buy Now",
            bgColor: Colors.white,
            onPressed: () async {
              await _homeContrstate.onBottomNavClick(2);
              Get.to(
                Home(),
              );
            },
          ),
          BuyAndAddToCartButton(
              title: "Add To Cart",
              bgColor: Theme.of(context).primaryColorDark,
              onPressed: () async {
                await _homeContrstate.onBottomNavClick(2);
                Get.to(
                  Home(),
                );
              }),
        ],
      ),
    );
  }

  Stack _productInfoWithImg() {
    return Stack(
      children: [
        _productInfo(),
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

  Widget _productInfo() {
    return Container(
      padding: EdgeInsets.only(
        left: 30.0,
      ),
      width: Get.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _price(650),
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
          _productSizes(),
          SizedBox(
            height: 20,
          ),
          _productQuantity(),
           SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  Widget _productSizes() {
    return Row(
      children: [
        for (String each in _prodDetailContr.productSizeList)
          EachProductBox(
            isSelected: _prodDetailContr.currentProductSize ==
                _prodDetailContr.productSizeList.indexOf(each),
            label: each,
            onPressed: () {
              _prodDetailContr.onProductSizeClick(
                _prodDetailContr.productSizeList.indexOf(each),
              );
            },
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
              fontWeight: FontWeight.w600,
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

  Widget _price(int price) {
    return Text(
      "Rs.$price",
      style: GoogleFonts.robotoSlab(
          fontWeight: FontWeight.w800, fontSize: 24, letterSpacing: 0.5),
    );
  }

  Widget _ingredient() {
    return SizedBox(
      width: Get.width * .65,
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

  Widget _titleInfo() {
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
              Get.to(
                Home(),
              );
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
