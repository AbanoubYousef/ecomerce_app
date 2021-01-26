import 'package:ecommerce/constans.dart';
import 'package:ecommerce/models/products.dart';
import 'package:ecommerce/provider/cart_item.dart';
import 'package:ecommerce/screens/users/product_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ecommerce/services/store.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  static String id = "CartScreen";

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Product> products = [];
  String _selctedAction;
  static const actions = <String>[
    "Delete",
    "Edit",
  ];
  final List<PopupMenuItem<String>> _actionMenuItems = actions
      .map((String val) => PopupMenuItem<String>(
            value: val,
            child: Text(val),
          ))
      .toList();
  String address;

  @override
  Widget build(BuildContext context) {
    products = Provider.of<CartItem>(context).products;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: kMainColor,
        title: Text(
          "Your Cart",
          style: TextStyle(color: Colors.black),
        ),
        actionsIconTheme: IconThemeData.fallback(),
        centerTitle: true,
        elevation: 0,
      ),
      body: products.isNotEmpty
          ? Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, i) {
                      int totalPrice = 0;
                      totalPrice += int.parse(products[i].pQuantity) *
                          int.parse(products[i].pPrice);
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          // padding: EdgeInsets.all(10),
                          height: MediaQuery.of(context).size.height * .15,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15.0),
                            ),
                            color: kSecondaryColor,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              CircleAvatar(
                                backgroundImage:
                                    AssetImage(products[i].pImageLocation),
                                maxRadius: MediaQuery.of(context).size.height *
                                    .15 /
                                    2,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text(
                                    products[i].pName,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 15),
                                        child: Text(
                                          "Items = ${products[i].pQuantity}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "Total = \$$totalPrice",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              PopupMenuButton(
                                  icon: Icon(
                                    Icons.more_vert,
                                  ),
                                  onSelected: (String val) {
                                    _selctedAction = val;
                                    if (_selctedAction == "Delete") {
                                      Navigator.pop(context);
                                      CartItem cartItem = Provider.of<CartItem>(
                                          context,
                                          listen: false);
                                      cartItem
                                          .deleteProductFromCart(products[i]);
                                    } else {
                                      // Navigator.pop(context);
                                      Navigator.pushNamed(
                                          context, ProductInfo.id,
                                          arguments: products[i]);
                                      products[i].pQuantity = "0";
                                      CartItem cartItem = Provider.of<CartItem>(
                                          context,
                                          listen: false);
                                      cartItem
                                          .deleteProductFromCart(products[i]);
                                    }
                                    print(_selctedAction);
                                  },
                                  itemBuilder: (BuildContext context) =>
                                      _actionMenuItems),
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: products.length,
                  ),
                ),
                Builder(
                 builder: (context)=> ButtonTheme(
                    minWidth: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * .12,
                    child: RaisedButton(
                        color: kMainColor,
                        onPressed: (){
                          showCustomDialog(context);
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                        ),
                        child: Text(
                          "Order",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                    ),
                ),
              ],
            )
          : Center(
              child: Text("Your Cart is Empty"),
            ),
    );
  }

  void showCustomDialog(BuildContext context) {
    var price = getTotalPrice();
    AlertDialog alertDialog = AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))),
      title: Text("Total Price = \$ $price"),
      content: TextField(
        decoration: InputDecoration(
          hintText: "Enter Your Address",
        ),
        onChanged: (val) {
          address = val;
        },
      ),
      actions: <Widget>[
        MaterialButton(
          onPressed: () {
            var _store = Store();
            try {
              _store.storeOrders({
                kAddress: address,
                kTotalPrice: price
              }, products);
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text("Order Added Successfully"),
                duration: Duration(milliseconds: 1000),
              ));
            } catch (ex) {
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text(ex.message),
                duration: Duration(milliseconds: 1500),
              ));
            }
            finally{
              Navigator.pop(context);
            }
          },
          child: Text("Confirm"),
        ),
        MaterialButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Close"),
        ),
      ],
    );
    showDialog(
      context: context,
        builder: (context) {
        return alertDialog;
        });
  }

  getTotalPrice() {
    var price = 0;
    for (var pdt in products) {
      price += int.parse(pdt.pPrice) * int.parse(pdt.pQuantity);
    }
    return price;
  }
}
