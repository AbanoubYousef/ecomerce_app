import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/constans.dart';
import 'package:ecommerce/models/products.dart';
import 'package:ecommerce/screens/admins/edit_product.dart';
import 'package:ecommerce/services/store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


// ignore: must_be_immutable
class ManageProducts extends StatelessWidget {
  static String id = "ManageProducts";
  final _store = Store();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondaryColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kMainColor,
        title: Text("Manage Products"),
        textTheme: TextTheme(title: TextStyle(color: Colors.black)),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _store.loadProducts(),
        builder: (context, snapShot) {
          List<Product> _product = [];
          if (!snapShot.hasData)
            return Center(child: CircularProgressIndicator());
          else {
            for (var doc in snapShot.data.documents) {
              var data = doc.data;
              _product.add(Product(
                pId: doc.documentID,
                pPrice: data[kPprice],
                pCategory: data[kPcategory],
                pDescreption: data[kPDescription],
                pImageLocation: data[kPimageLocation],
                pName: data[kPname],
                pQuantity: data[kPquantity],
              ));
            }
          }

          return GridView.builder(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (context, i) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: Image(
                      image: AssetImage(_product[i].pImageLocation),
                      fit: BoxFit.fill,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Opacity(
                      opacity: .7,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        color: Colors.black,
                        child: Row(
                          children: <Widget>[
                            PopupMenuButton(
                                icon: Icon(Icons.more_vert,color:kMainColor,),
                                onSelected: (String val) {
                              _selctedAction = val;
                              if(_selctedAction=="Delete"){
                                _store.deleteProduct(_product[i].pId);
                               // print(_product[i].pId);
                              } else{
                                Navigator.pushNamed(context, EditProduct.id, arguments: _product[i]);
                              }
                              print(_selctedAction);
                            }, itemBuilder: (BuildContext context) =>_actionMenuItems),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    _product[i].pName,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: kMainColor,
                                    ),
                                  ),
                                  Text(
                                    " \$${_product[i].pPrice}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: kMainColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            itemCount: _product.length,
          );
        },
      ),
    );
  }
}
