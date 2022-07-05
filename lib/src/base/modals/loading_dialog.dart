import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: AlertDialog(
        content: Column(mainAxisSize: MainAxisSize.min, children: const [
          CircularProgressIndicator(),
          SizedBox(height: 20),
          Text('Loading...'),
        ]),
      ),
    );
  }

  void show(BuildContext context) {
    showDialog(context: context, builder: (ctx) => this);
  }
}
