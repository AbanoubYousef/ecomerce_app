import 'package:flutter/cupertino.dart';

class ModelHud extends ChangeNotifier{
  bool isLoading = false;
  changeLoading(bool val){
    isLoading = val;
    notifyListeners();
  }

}