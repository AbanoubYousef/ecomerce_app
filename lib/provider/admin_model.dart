import 'package:flutter/cupertino.dart';

class AdminModel extends ChangeNotifier{
  bool isAdmin=false;
   changeisAdmin(bool val){
     isAdmin= val;
     notifyListeners();
   }

}