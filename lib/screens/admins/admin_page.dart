import 'package:ecommerce/constans.dart';
import 'package:ecommerce/screens/admins/add_product.dart';
import 'package:ecommerce/screens/admins/manage_products.dart';
import 'package:ecommerce/screens/admins/show_orders.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class AdminPage extends StatelessWidget {
  static String id = "AdminPage";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kMainColor,
        title: Text("Admin Page"),
        textTheme: TextTheme(title: TextStyle(color: Colors.black)),
      ),
      backgroundColor: kSecondaryColor,
      body: Center(
        child: ListView(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 85,
                width: 85,
                child: Image.asset("assets/images/buy.png"),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width*.8,
              child: FlatButton(
                color: kMainColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, AddProduct.id);
                },
                child: Text("AddProduct"),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width*.8,
              child: FlatButton(
                color: kMainColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, ManageProducts.id);
                },
                child: Text("MangeProducts"),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width*.8,
              child: FlatButton(
                color: kMainColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, ShowOrders.id);
                },
                child: Text("ShowOrders"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
