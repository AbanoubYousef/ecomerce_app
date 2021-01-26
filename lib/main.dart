import 'package:ecommerce/constans.dart';
import 'package:ecommerce/provider/admin_model.dart';
import 'package:ecommerce/provider/cart_item.dart';
import 'package:ecommerce/provider/model_hud.dart';
import 'package:ecommerce/screens/admins/add_product.dart';
import 'package:ecommerce/screens/admins/admin_page.dart';
import 'package:ecommerce/screens/admins/edit_product.dart';
import 'package:ecommerce/screens/admins/manage_products.dart';
import 'package:ecommerce/screens/admins/order_detailes.dart';
import 'package:ecommerce/screens/admins/show_orders.dart';
import 'package:ecommerce/screens/users/cart_screen.dart';
import 'package:ecommerce/screens/users/home_screen.dart';
import 'package:ecommerce/screens/login_screen.dart';
import 'package:ecommerce/screens/signup_screen.dart';
import 'package:ecommerce/screens/users/product_info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLogged = false;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context,snapshot){
        if(!snapshot.hasData){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(child: CircularProgressIndicator(),),
            ),
          );
        }
        else{
          isLogged = snapshot.data.getBool(kKeepMeLoggedIn) ?? false;
          return MultiProvider(
            providers: [
              ChangeNotifierProvider<ModelHud>(
                create: (context) => ModelHud(),
              ),
              ChangeNotifierProvider<CartItem>(
                create: (context) => CartItem(),
              ),
              ChangeNotifierProvider<AdminModel>(
                create: (context) => AdminModel(),
              ),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              initialRoute: isLogged ? HomePage.id : LoginScreen.id,
              routes: {
                OrderDetailes.id : (context)=>OrderDetailes(),
                ShowOrders.id : (context)=>ShowOrders(),
                ProductInfo.id: (context)=> ProductInfo(),
                CartScreen.id: (context)=>CartScreen(),
                LoginScreen.id: (context) => LoginScreen(),
                SignUpScreen.id: (context) => SignUpScreen(),
                HomePage.id: (context) => HomePage(),
                AdminPage.id: (context)=>AdminPage(),
                AddProduct.id: (context)=>AddProduct(),
                ManageProducts.id: (context)=>ManageProducts(),
                EditProduct.id: (context)=>EditProduct(),
              },
            ),
          );
        }

      },
    );
  }
}
