import 'package:ecommerce/provider/admin_model.dart';
import 'package:ecommerce/provider/model_hud.dart';
import 'package:ecommerce/screens/admins/admin_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:ecommerce/screens/users/home_screen.dart';
import 'package:ecommerce/screens/signup_screen.dart';
import 'package:ecommerce/services/auth.dart';
import 'package:ecommerce/widgets/custom_TextFiled.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constans.dart';

// ignore: must_be_immutable
class LoginScreen extends StatefulWidget {
  static String id = "LoginScreen";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  String email, password;

  final _auth = Auth();

  bool keepMeLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: kMainColor,
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<ModelHud>(context).isLoading,
        child: Form(
          key: _key,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 85,
                  width: 85,
                  child: Image.asset("assets/images/buy.png"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  alignment: AlignmentDirectional.center,
                  child: Text(
                    "BUY IT",
                    style: TextStyle(
                      fontFamily: "Pacifico",
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .1,
              ),
              // email textfield
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomTextFiled(
                  hint: "Enter your email",
                  icon: Icons.email,
                  save: (val) {
                    email = val;
                  },
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .02,
              ),
              // password textfield
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomTextFiled(
                  hint: "Enter your password",
                  icon: Icons.lock,
                  save: (val) {
                    password = val;
                  },
                ),
              ),

              CheckboxListTile(
                value: keepMeLoggedIn,
                onChanged: (value) {
                  setState(() {
                    keepMeLoggedIn = value;
                  });
                },
                title: Text("Remember Me"),
                activeColor: kSecondaryColor,
                checkColor: Colors.white,
              ),
              // login button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100),
                child: Builder(
                  builder: (context) => FlatButton(
                    color: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    onPressed: () async {
                      if(keepMeLoggedIn == true){
                         keepUserLoggedin();
                      }
                      _validation(context);
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .05,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Don't have an account? ",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, SignUpScreen.id);
                      },
                      child: Text(
                        "Register",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Provider.of<AdminModel>(context, listen: false)
                            .changeisAdmin(true);
                      },
                      child: Text(
                        "I'm an admin",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Provider.of<AdminModel>(context).isAdmin
                              ? kMainColor
                              : Colors.white,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Provider.of<AdminModel>(context, listen: false)
                            .changeisAdmin(false);
                      },
                      child: Text(
                        "I'm a user",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Provider.of<AdminModel>(context).isAdmin
                              ? Colors.white
                              : kMainColor,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _validation(BuildContext context) async {
    final adminPassword = "admin12345";
    final modelHud = Provider.of<ModelHud>(context, listen: false);
    modelHud.changeLoading(false);
    if (_key.currentState.validate()) {
      _key.currentState.save();
      if (Provider.of<AdminModel>(context, listen: false).isAdmin) {
        if (password == adminPassword) {
          try {
            final result = await _auth.signIn(email, password);
            modelHud.changeLoading(false);
            Navigator.pushNamed(context, AdminPage.id);
          } on PlatformException catch (e) {
            modelHud.changeLoading(false);
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text(e.message),
              ),
            );
          }
        } else {
          modelHud.changeLoading(false);
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text("Wrong Password"),
            ),
          );
        }
      } else {
        try {
          final result = await _auth.signIn(email, password);
          modelHud.changeLoading(false);
          Navigator.pushNamed(context, HomePage.id);
        } on PlatformException catch (e) {
          modelHud.changeLoading(false);
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text(e.message),
            ),
          );
        }
      }
    }
    modelHud.changeLoading(false);
  }

  void keepUserLoggedin() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool(kKeepMeLoggedIn, keepMeLoggedIn);

  }
}
