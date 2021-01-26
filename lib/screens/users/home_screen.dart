
import 'package:ecommerce/screens/login_screen.dart';
import 'package:ecommerce/services/auth.dart';
import 'package:ecommerce/widgets/products_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constans.dart';
import 'cart_screen.dart';


class HomePage extends StatefulWidget {
  static String id = "HomePage";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _auth = Auth();
  int _currentIndex = 0;
  FirebaseUser _currentUser;

  getUser() async {
    _currentUser = await _auth.getCurrentUser();
  }

  @override
  void initState() {
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kMainColor,
          automaticallyImplyLeading: false,
          title: Text(
            "Discover".toUpperCase(),
            style: TextStyle(color: Colors.black),
          ),
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
          bottom: TabBar(
            indicatorPadding:
                EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            indicator: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.all(Radius.circular(25)),
            ),
            labelColor: kMainColor,
            unselectedLabelStyle: TextStyle(
              fontSize: 14,
            ),
            unselectedLabelColor: Colors.black45,
            labelStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            tabs: [
              Text(kCjackets),
              Text(kCtshirts),
              Text(kCtrouser),
              Text(kCshoes),
            ],
            labelPadding: EdgeInsets.all(8),
            onTap: (val) {
              setState(() {
                _currentIndex = val;
              });
            },
            indicatorColor: Colors.black,
          ),
        ),
        body: TabBarView(children: [
          JacketView(),
         productsView(category: kCtshirts),
         productsView(category: kCtrouser),
         productsView(category: kCshoes),
        ]),
        drawer: Drawer(
          child: ListTile(
            title: Text("Log Out"),
            leading: Icon(Icons.exit_to_app),
            onTap: () async{
              SharedPreferences preferences = await SharedPreferences.getInstance();
              preferences.clear();
              await _auth.signOut();
              Navigator.popAndPushNamed(context, LoginScreen.id);
            },
          ),
        ),
      ),
    );
  }
}



