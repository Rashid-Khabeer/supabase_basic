import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog(
    this.error, {
    Key? key,
  }) : super(key: key);

  final String error;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Error'),
      content: Text(error),
      actions: [
        TextButton(
          onPressed: Navigator.of(context).pop,
          child: const Text('Ok'),
        ),
      ],
    );
  }

  void show(BuildContext context) {
    showDialog(context: context, builder: (ctx) => this);
  }
}
