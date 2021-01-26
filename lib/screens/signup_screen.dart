import 'package:ecommerce/provider/model_hud.dart';
import 'package:ecommerce/screens/login_screen.dart';
import 'package:ecommerce/services/auth.dart';
import 'package:ecommerce/widgets/custom_TextFiled.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../constans.dart';
import 'users/home_screen.dart';

// ignore: must_be_immutable
class SignUpScreen extends StatelessWidget {
  static String id = "SignUpScreen";
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String email, password;
  final _auth = Auth();

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
        backgroundColor: kMainColor,
        body: ModalProgressHUD(
          inAsyncCall:Provider.of<ModelHud>(context).isLoading ,
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomTextFiled(
                    hint: "Enter your name",
                    icon: Icons.person,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: CustomTextFiled(
                      hint: "Enter your email",
                      icon: Icons.email,
                      save:(value){
                        email=value;
                      } ,
                    ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomTextFiled(
                    hint: "Enter your password",
                    icon: Icons.lock,
                    save:(value){
                      password=value;
                    } ,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .05,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100),
                  child: Builder(
                    builder: (context)=> FlatButton(
                      color: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      onPressed: () async {
                        final modelHud=Provider.of<ModelHud>(context,listen: false);
                        modelHud.changeLoading(true);
                        if (_key.currentState.validate()) {
                          _key.currentState.save();
                          try{
                            final result = await _auth.register(email, password);
                            modelHud.changeLoading(false);
                            Navigator.pushNamed(context, HomePage.id);
                          } on PlatformException catch(e){
                            modelHud.changeLoading(false);
                            Scaffold.of(context).showSnackBar(SnackBar(content: Text(e.message),),);
                          }
                        }
                        modelHud.changeLoading(false);
                      },
                      child: Text(
                        "Register",
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
                        "Do you have an account? ",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, LoginScreen.id);
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(color: Colors.black, fontSize: 16),
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
}
