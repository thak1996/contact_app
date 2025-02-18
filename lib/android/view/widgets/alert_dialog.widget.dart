import 'package:flutter/material.dart';

class AlertDialogWidget extends StatelessWidget {
  const AlertDialogWidget({super.key, required this.mesage});

  final String mesage;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Erro'),
      content: Text(mesage),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('OK'),
        ),
      ],
    );
  }
}
