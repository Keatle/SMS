import 'package:flutter/material.dart';


class ColorProvider with ChangeNotifier 
{
  Color _headerColor = const Color.fromARGB(255, 248, 122, 12); 

  Color get headerColor => _headerColor;

  void setHeaderColor(Color color) {
    _headerColor = color;
    notifyListeners(); 
  }
}
