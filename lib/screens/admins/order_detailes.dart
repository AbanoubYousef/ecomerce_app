import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/constans.dart';
import 'package:ecommerce/models/products.dart';
import 'package:ecommerce/services/store.dart';
import 'package:flutter/material.dart';
class OrderDetailes extends StatelessWidget {
  static String id = "OrderDetailes";
  Store _store = Store();
  @override
    Widget build(BuildContext context) {
    var documentId = ModalRoute.of(context).settings.arguments;
      return Scaffold(
        appBar: AppBar(
          backgroundColor: kMainColor,
          title: Text("Order Detailes"),
          textTheme: TextTheme(title: TextStyle(color: Colors.black)),
          centerTitle: true,
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: _store.ordersDetailes(documentId),
          builder: (context, snapShot) {
            List<Product> products = [];
            if (!snapShot.hasData)
              return Center(child: CircularProgressIndicator());
            else {
              for (var doc in snapShot.data.documents) {
                var data = doc.data;
                products.add(Product(
                   pName: data[kPname],
                  pPrice: data[kPprice],
                  pQuantity: data[kPquantity],
                  pImageLocation: data[kPimageLocation]
                ));
              }
            }
            return ListView.builder(
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
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                      ],
                    ),
                  ),
                );
              },
              itemCount: products.length,
            );
          },
        ),
      );
    }
}
