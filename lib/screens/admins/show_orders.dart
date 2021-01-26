import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/models/order.dart';
import 'package:ecommerce/screens/admins/order_detailes.dart';
import 'package:ecommerce/services/store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constans.dart';

class ShowOrders extends StatelessWidget {
  static String id = "ShowOrders";
  Store _store = Store();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         backgroundColor: kMainColor,
        title: Text("Orders"),
        textTheme: TextTheme(title: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _store.loadOrders(),
        builder: (context, snapShot) {
          List<Order> orders = [];
          if (!snapShot.hasData)
            return Center(child: CircularProgressIndicator());
          else {
            for (var doc in snapShot.data.documents) {
              var data = doc.data;
              orders.add(Order(
                  address: doc.data[kAddress],
                  totalPrice: doc.data[kTotalPrice],
                documentId:  doc.documentID
              ));
            }
          }
          return ListView.builder(itemBuilder: (context, i){
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: kSecondaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(15))
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.all(8),
                  onTap: (){
                    Navigator.pushNamed(context, OrderDetailes.id,arguments:orders[i].documentId );
                  },
                  title: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(orders[i].address),
                  ),
                  trailing:Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Text("\$ ${orders[i].totalPrice}"),
                  ) ,
                ),
              ),
            );
          },itemCount: orders.length,);
        },
      ),
    );
  }
}
