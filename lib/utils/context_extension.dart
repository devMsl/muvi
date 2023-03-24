import 'package:flutter/material.dart';

extension ContextExtenstion on BuildContext{
  double get height{
    return MediaQuery.of(this).size.height;
  }

  double get width{
    return MediaQuery.of(this).size.width;
  }

  Future<T?> pushed<T extends Object>(Widget widget) async {
    return await Navigator.of(this).push(MaterialPageRoute(builder: (context) {
      return widget;
    }));
  }

  void backed<T extends Object>([T? result]) {
    Navigator.of(this).pop<T>(result);
  }
}