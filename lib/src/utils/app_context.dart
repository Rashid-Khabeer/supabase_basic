import 'package:flutter/material.dart';

extension AppContext on BuildContext {
  void showSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Future<dynamic> to(Widget page) async {
    return await Navigator.of(this).push(MaterialPageRoute(
      builder: (context) => page,
    ));
  }

  navigateRemoveUntil(Widget page) {
    Navigator.pushAndRemoveUntil<dynamic>(
      this,
      MaterialPageRoute<dynamic>(builder: (BuildContext con) => page),
      (route) => false,
    );
  }

  pop() => Navigator.of(this).pop();
}
