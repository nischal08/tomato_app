import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tomato_app/contants/color_properties.dart';
import 'package:tomato_app/controller/carts.dart';
import 'package:tomato_app/controller/home_controller.dart';
import 'package:tomato_app/controller/product_detail_controller.dart';
import 'package:tomato_app/models/product_list.dart' as prod;
import 'package:tomato_app/widgets/each_product_box.dart';
import 'package:tomato_app/widgets/custom_icon_button.dart';
import 'package:tomato_app/widgets/circular_button.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail';
  late ProductDetailController _prodDetailContr;
  late HomeController _homeCtrlrstate;

  late prod.Datum product;

  bool _checkBigDeviceSize(context) {
    return MediaQuery.of(context).size.height > 500 ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    product = ModalRoute.of(context)!.settings.arguments as prod.Datum;

    _prodDetailContr = Provider.of<ProductDetailController>(context);
    _homeCtrlrstate = Provider.of<HomeController>(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(
            left: 10,
            top: 10,
          ),
          child: _appbarAction(context),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: _body(context),
    );
  }

  Widget _body(context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Expanded(flex:4, child: _upperContainer(context)),
          _lowerContainer(context),
        ],
      ),
    );
  }

  Widget _lowerContainer(context) {
    return Expanded(flex:7,
      child: Container(
        // height: MediaQuery.of(context).size.height*0.60-MediaQuery.of(context).padding.bottom-kBottomNavigationBarHeight,
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        decoration: BoxDecoration(
            // borderRadius: BorderRadius.only(
            //   topLeft: Radius.circular(40),
            //   topRight: Radius.circular(40),
            // ),
            color: Theme.of(context).cardColor),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                child: _title(),
              ),
              SizedBox(height: 20),
              _ingredient(context),
              SizedBox(height: 30),
              _productInfoRow(context),
              SizedBox(
                height: 30,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.40,
                      child: Text(
                        "How many do you want? ",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    _productQuantity(),
                  ],
                ),
              ),
              SizedBox(height: 30),
              _venderInfo(context),
              SizedBox(
                height: 30,
              ),
              _transactionBtn(context),
              SizedBox(
                height: kBottomNavigationBarHeight+10,
              ),
            ],
          ),
        ),
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
                  product.restaurant.name,
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
      child: _productImage(context),
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
          key: "Category",
          value: product.category.name,
        ),
      ],
    );
  }

  Widget _productImage(context) {
    return Image.network(
      "https://cdn.dnaindia.com/sites/default/files/styles/full/public/2017/09/27/612590-momos-092717.jpg",
      // height: _checkBigDeviceSize(context) ? 350 : 250,
      fit: BoxFit.fitHeight,
      // width: double.infinity,
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
              Provider.of<Carts>(context, listen: false).addCartItem(
                  product: product, quantity: _prodDetailContr.currentQuantity);
              Provider.of<ProductDetailController>(context, listen: false)
                  .onChangeQntyToDefVal();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("${product.name} is added to cart."),
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
            color: Colors.black,
          ),
        ),
        EachProductBox(
          isSelected: true,
          label: _prodDetailContr.currentQuantity.toString(),
          onPressed: () {},
        ),
        IconButton(
          onPressed: () => _prodDetailContr.onIncrQuantity(),
          icon: Icon(
            Icons.add,
            color: Colors.black,
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
            product.reciepe,
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
      height: 50,
      width: 50,
      // alignment: Alignment.topLeft,

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
    return Text(
      product.name,
      textAlign: TextAlign.center,
      style: GoogleFonts.raleway(
        fontSize: 22,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
