import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shamo/models/product_model.dart';
import 'package:shamo/pages/detail_chat_page.dart';
import 'package:shamo/providers/cart_provider.dart';
import 'package:shamo/providers/wishlist_provider.dart';
import 'package:shamo/theme.dart';

class ProductPage extends StatefulWidget {
  final ProductModel product;
  ProductPage(this.product);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List images = [
    'assets/image_shoes.png',
    'assets/image_shoes.png',
    'assets/image_shoes.png',
  ];

  List familiarShoes = [
    'assets/image_shoes.png',
    'assets/image_shoes2.png',
    'assets/image_shoes3.png',
    'assets/image_shoes4.png',
    'assets/image_shoes5.png',
    'assets/image_shoes6.png',
    'assets/image_shoes7.png',
    'assets/image_shoes8.png',
  ];

  int currentIndex = 0;
  bool _doRedeem = false;

  @override
  Widget build(BuildContext context) {
    WishlistProvider wishlistProvider = Provider.of<WishlistProvider>(context);
    CartProvider cartProvider = Provider.of<CartProvider>(context);

    Future<void> showSuccessDialog() async {
      return showDialog(
        context: context,
        builder: (BuildContext context) => Container(
          width: MediaQuery.of(context).size.width - (2 * defaultMargin),
          child: AlertDialog(
            backgroundColor: backgroundColor3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.close,
                        color: primaryTextColor,
                      ),
                    ),
                  ),
                  Image.asset(
                    'assets/icon_success.png',
                    width: 100,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    'Hore :)',
                    style: primaryTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: semiBold,
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    'Redeem Point berhasil!',
                    style: secondaryTextStyle,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 154,
                    height: 44,
                    child: TextButton(
                      onPressed: () {
                        // Navigator.pushNamed(context, '/cart');
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Tutup',
                        style: primaryTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: medium,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    Widget indicator(int index) {
      return Container(
        width: currentIndex == index ? 16 : 4,
        height: 4,
        margin: EdgeInsets.symmetric(
          horizontal: 2,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: currentIndex == index ? primaryColor : Color(0xffC4C4C4),
        ),
      );
    }

    Widget familiarShoesCard(String imageUrl) {
      return Container(
        width: 54,
        height: 54,
        margin: EdgeInsets.only(
          right: 16,
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imageUrl),
          ),
          borderRadius: BorderRadius.circular(6),
        ),
      );
    }

    Widget header() {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Image.asset(
            widget.product.galleries[0].url,
            width: MediaQuery.of(context).size.width,
            height: 310,
            fit: BoxFit.cover,
          ),
        ),
      );
    }

    Widget content() {
      return Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 17),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(24),
          ),
          color: backgroundColor1,
        ),
        child: Column(
          children: [
            // NOTE: HEADER (nama voucher)
            Container(
              margin: EdgeInsets.only(
                top: defaultMargin,
                left: defaultMargin,
                right: defaultMargin,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.product.name,
                          style: primaryTextStyle.copyWith(
                            fontSize: 18,
                            fontWeight: semiBold,
                          ),
                        ),
                        Text(
                          widget.product.category.name,
                          style: secondaryTextStyle.copyWith(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // NOTE: DESCRIPTION
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(
                top: normalMargin,
                left: defaultMargin,
                right: defaultMargin,
              ),
              child: Text(
                widget.product.description,
                style: subtitleTextStyle.copyWith(
                  fontWeight: extraLight,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackButton(
          color: blackColor,
        ),
        automaticallyImplyLeading: true,
        title: Text(
          _doRedeem ? 'Redeem' : 'Voucher',
          style: primaryTextStyle,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                header(),
                content(),
              ],
            ),
          ),

          _doRedeem
              ? _coupon()
              : Container(
                  // NOTE: POINTS
                  width: double.infinity,
                  margin: EdgeInsets.only(
                    top: 20,
                    left: defaultMargin,
                    right: defaultMargin,
                  ),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Buy',
                        style: primaryTextStyle,
                      ),
                      Column(
                        children: [
                          Text(
                            '${widget.product.price}',
                            style: priceTextStyle.copyWith(
                                fontSize: 20,
                                fontWeight: semiBold,
                                color: blackColor),
                          ),
                          Text(
                            'Points',
                            style: priceTextStyle.copyWith(
                                fontSize: 14,
                                fontWeight: semiBold,
                                color: blackColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

          // NOTE: BUTTONS
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(
                vertical: normalMargin, horizontal: defaultMargin),
            child: Expanded(
              child: Container(
                height: 54,
                child: TextButton(
                  onPressed: () {
                    // cartProvider.addCart(widget.product);
                    // showSuccessDialog();
                    setState(() {
                      _doRedeem = !_doRedeem;
                    });
                    if (!_doRedeem) Navigator.pop(context);
                  },
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: primaryColor,
                  ),
                  child: Text(
                    _doRedeem ? 'USE IT' : 'REDEEM',
                    style: primaryTextStyle.copyWith(
                      fontSize: 20,
                      fontWeight: bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _coupon() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(
        top: normalMargin,
        left: defaultMargin,
        right: defaultMargin,
      ),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        children: [
          Text(
            'COUPON CODE',
            style: primaryTextStyle.copyWith(
              fontSize: 20,
              fontWeight: regular,
            ),
          ),
          SizedBox(
            height: 2,
          ),
          Text(
            'XFJIOYU212N4J',
            style: priceTextStyle.copyWith(
                fontSize: 30, fontWeight: bold, color: blackColor),
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            'Kode akan dikirim ke akun email Anda',
            style: priceTextStyle.copyWith(
                fontSize: 14, fontWeight: regular, color: secondaryTextColor),
          ),
        ],
      ),
    );
  }
}
