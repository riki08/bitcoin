// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bitcoin/providers/bitcoin_provider.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bitcoinProvider = Provider.of<BitcoinProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detalle de divisa',
          style: TextStyle(fontSize: 25),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Text(bitcoinProvider.priceCOP!),
            Text(bitcoinProvider.priceEUR!),
          ],
        ),
      ),
    );
  }
}
