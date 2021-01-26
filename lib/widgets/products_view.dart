import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/screens/users/product_info.dart';
import 'package:ecommerce/services/store.dart';
import 'package:flutter/material.dart';
import '../constans.dart';
import '../models/products.dart';
final _store = Store();
List<Product> _products = [];

Widget JacketView() {
  return StreamBuilder<QuerySnapshot>(
    stream: _store.loadProducts(),
    builder: (context, snapShot) {
      List<Product> product = [];
      if (!snapShot.hasData)
        return Center(child: CircularProgressIndicator());
      else {
        for (var doc in snapShot.data.documents) {
          var data = doc.data;
          product.add(Product(
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
      _products = [...product];
      product.clear();
      return productsView(category: kCjackets);
    },
  );
}

List<Product> getPrductByCat({String category}) {
  List<Product> products = [];
  for (var product in _products){
    if(product.pCategory==category){
      products.add(product);
    }
  }
  return products;
}

Widget productsView({ String category}) {
List<Product> products = [];
 products=getPrductByCat(category: category);
 if(products.isEmpty) return Center(child: CircularProgressIndicator());
  else return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: products.length,
      itemBuilder: (context, i) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, ProductInfo.id,arguments: products[i]);
            },
            child:  Stack(
            children: <Widget>[
              Positioned.fill(
                child: Image(
                  image: AssetImage(products[i].pImageLocation),
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
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            products[i].pName,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: kMainColor,
                            ),
                          ),
                          Text(
                            " \$ ${products[i].pPrice}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: kMainColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
            ),
        ),
      ),
  );
}
