import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tomato_app/contants/color_properties.dart';
import 'package:tomato_app/controller/carts.dart';
import 'package:tomato_app/controller/home_controller.dart';
import 'package:tomato_app/models/product_list.dart';
import 'package:tomato_app/screens/product_detail_screen.dart';

class ProductCard extends StatefulWidget {
  final BuildContext ctx;

  ProductCard(this.ctx);

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool _isitemAdded = false;

  @override
  Widget build(BuildContext context) {
    final Datum product = Provider.of<Datum>(context);

    return Container(
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, ProductDetailScreen.routeName,
                  arguments: product);
            },
            child: Container(
              child: _card(context, product),
            ),
          ),
          Positioned(
            right: 30,
            top: 1,
            child: GestureDetector(
              onTap: () {
                Provider.of<Carts>(context, listen: false)
                    .addCartItem(product: product);
                setState(
                  () {
                    _isitemAdded = true;
                  },
                );
              },
              child: _addtoCart(context),
            ),
          ),
          Positioned(
            right: 25,
            bottom: 20,
            child: _favBtn(context, product.isFavorite),
          ),
        ],
      ),
    );
  }

  Widget _favBtn(context, isFav) {
    return Consumer<Datum>(
      builder: (context, prod, child) => Material(
        color: Colors.transparent,
        child: IconButton(
          splashRadius: 1,
          onPressed: () {
            prod.toggleFavoriteStatus();
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
          icon: Icon(
            isFav ? Icons.favorite : Icons.favorite_border,
            size: 22,
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }

  Widget _addtoCart(context) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        _isitemAdded
            ? CupertinoIcons.check_mark
            : CupertinoIcons.cart_badge_plus,
        size: 20,
        color: Theme.of(context).cardColor,
      ),
    );
  }

  Widget _card(context, product) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      height: 160,
      child: Card(
        margin: EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 20,
        ),
        color: Theme.of(context).cardColor,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _itemImage(context, product),
            SizedBox(
              width: 20,
            ),
            Flexible(
              fit: FlexFit.loose,
              child: _info(context, product),
            ),
          ],
        ),
      ),
    );
  }

  Widget _itemImage(context, Datum product) {
    return ClipPath(
      clipper: ShapeBorderClipper(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          bottomLeft: Radius.circular(15),
        )),
      ),
      child: Container(
        height: double.infinity,
        width: MediaQuery.of(context).size.width * 0.38,
        // padding: EdgeInsets.all(5),
        child: Image.network(
          "https://cdn.dnaindia.com/sites/default/files/styles/full/public/2017/09/27/612590-momos-092717.jpg",
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _info(context, product) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _rating(context, product),
          SizedBox(height: 6),
          _title(context, product),
          SizedBox(height: 6),
          _price(context, product)
        ],
      ),
    );
  }

  Widget _price(context, Datum product) {
    return Text(
      "Rs.${product.price.toStringAsFixed(0)}",
      style: GoogleFonts.openSans(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Theme.of(context).accentColor,
      ),
    );
  }

  Widget _rating(context, Datum product) {
  return  Container(
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.circular(8)),
      child: Text(
         "4.6",
        style: Theme.of(context)
            .textTheme
            .subtitle2!
            .copyWith(color: kColorWhiteText, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _title(context, Datum product) {
    return Text(
      product.name,
      overflow: TextOverflow.fade,
      softWrap: false,
      style: Theme.of(context).textTheme.subtitle1!.copyWith(fontWeight: FontWeight.w600),
    );
  }

  
}
