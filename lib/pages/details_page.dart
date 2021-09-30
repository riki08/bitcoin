// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detalle de divisa',
          style: TextStyle(fontSize: 25),
        ),
      ),
      body: Center(
        child: Text('Hola Mundo'),
      ),
    );
  }
}
