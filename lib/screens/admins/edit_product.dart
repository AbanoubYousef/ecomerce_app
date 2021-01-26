import 'package:ecommerce/constans.dart';
import 'package:ecommerce/models/products.dart';
import 'package:ecommerce/services/store.dart';
import 'package:ecommerce/widgets/custom_TextFiled.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EditProduct extends StatelessWidget {

  static String id ="EditProduct";
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  String _name, _price, _category, _imageLocation, _quantity, _description;
  final _store =Store();
  @override
  Widget build(BuildContext context) {
    Product product = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: kMainColor,
      appBar: AppBar(
        title: Text("Edit Product", style: TextStyle(color: Colors.black),),
        centerTitle: true,
        backgroundColor: kSecondaryColor,
        iconTheme: IconThemeData(color: Colors.black),
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
                    _store. editProduct(({
                      kPname: _name,
                      kPprice: _price,
                      kPcategory: _category,
                      kPquantity: _quantity,
                      kPimageLocation: _imageLocation,
                      kPDescription: _description
                    }), product.pId);
                  }
                },
                child: Text("Edit Product",style: TextStyle(color: Colors.white),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
