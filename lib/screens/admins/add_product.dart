import 'package:ecommerce/constans.dart';
import 'package:ecommerce/models/products.dart';
import 'package:ecommerce/services/store.dart';
import 'package:ecommerce/widgets/custom_TextFiled.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddProduct extends StatelessWidget {

  static String id ="AddProduct";
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  String _name, _price, _category, _imageLocation, _quantity, _description;
  final _store =Store();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kMainColor,
        title: Text("Add Product"),
        textTheme: TextTheme(title: TextStyle(color: Colors.black)),
      ),
      body: Form(
        key: _key,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: ListView(
            children: <Widget>[
              CustomTextFiled(
                hint: "product name",
                save: (value) {
                  _name = value;
                },
              ),
              SizedBox(height: 10,),
              CustomTextFiled(
                hint: "product quantity",
                save: (value) {
                  _quantity = value;
                },
              ),
              SizedBox(height: 10,),
              CustomTextFiled(
                hint: "product description",
                save: (value) {
                  _description = value;
                },
              ),
              SizedBox(height: 10,),
              CustomTextFiled(
                hint: "product price",
                save: (value) {
                  _price = value;
                },
              ),
              SizedBox(height: 10,),
              CustomTextFiled(
                hint: "product category",
                save: (value) {
                  _category = value;
                },
              ),
              SizedBox(height: 10,),
              CustomTextFiled(
                hint: "product imageLocation",
                save: (value) {
                  _imageLocation = value;
                },
              ),
              SizedBox(height: 10,),
              RaisedButton(
                color: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                onPressed: () {
                  if (_key.currentState.validate()) {
                    _key.currentState.save();
                    _store.addProduct(Product(
                      pCategory: _category,
                      pDescreption: _description,
                      pImageLocation: _imageLocation,
                      pName: _name,
                      pPrice: _price,
                      pQuantity: _quantity,
                    ));
                  }
                },
                child: Text("Add Product",style: TextStyle(color: Colors.white),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
