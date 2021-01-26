import 'package:ecommerce/models/products.dart';
import 'package:ecommerce/provider/cart_item.dart';
import 'package:ecommerce/screens/users/cart_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constans.dart';
import 'home_screen.dart';

class ProductInfo extends StatefulWidget {
  static String id = "ProductInfo";

  @override
  _ProductInfoState createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  int _pQuantity = 1;

  @override
  Widget build(BuildContext context) {
    final Product product = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kMainColor,
        title: Text(
          product.pName,
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      iconTheme: IconThemeData.fallback(),
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.black),
            onPressed: () {
              Navigator.pushNamed(context, CartScreen.id);
            },
            padding: EdgeInsets.symmetric(horizontal: 20),
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage(
                product.pImageLocation,
              ),
              fit: BoxFit.fill,
            )),
          ),
          Positioned(
            bottom: 0,
            child: Opacity(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                height: MediaQuery.of(context).size.height * .45,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height * .33,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            ListTile(
                              leading: Text(
                                product.pName,
                                style: TextStyle(color: kMainColor),
                              ),
                              trailing: Text("\$ ${product.pPrice}",
                                  style: TextStyle(color: kMainColor)),
                            ),
                            ListTile(
                              title: Text("product.pDescreption",
                                  style: TextStyle(color: kMainColor)),
                            ),
                            Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  GestureDetector(
                                    child: Icon(
                                      Icons.add,
                                      color: kMainColor,
                                      size: 30,
                                    ),
                                    onTap: (){
                                      setState(() {
                                        _pQuantity++;
                                      });
                                    },
                                  ),
                                  Text(
                                    _pQuantity.toString(),
                                    style: TextStyle(
                                      fontSize: 30,
                                      color: kMainColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  GestureDetector(
                                    child: Icon(
                                      Icons.remove,
                                      color: kMainColor,
                                      size: 30,
                                    ),
                                    onTap: (){
                                      if(_pQuantity>1){
                                        setState(() {
                                          _pQuantity--;
                                        });
                                      }
                                    },
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    ButtonTheme(
                      minWidth: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * .12,
                      child: Builder(
                        builder: (context)=> RaisedButton(
                          color: kMainColor,
                          onPressed: (){
                            addToCart(context,product);
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                            ),
                          ),
                          child: Text(
                            "Add To Cart",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              opacity: .7,
            ),
          ),
        ],
      ),
    );
  }

  void addToCart(context, Product product) {
    CartItem cartItem= Provider.of<CartItem>(context,listen: false);
    product.pQuantity =_pQuantity.toString();
    bool isExist = false;
    var productInCart = cartItem.products;
    for(var pdt in productInCart){
      if(pdt.pName == product.pName) {
        isExist=true;
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("This Product Was Added Before"),
          duration: Duration(
              milliseconds: 1500
          ),
        ));
      }
    }
    if(!isExist){
      cartItem.addProductToCart(product);
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Product added to cart"),
        duration: Duration(
            milliseconds: 1000
        ),
      ));
    }
  }
}
