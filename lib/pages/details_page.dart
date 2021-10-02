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
      body: Container(
        margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                '\$${bitcoinProvider.selectedPrice} ' +
                    bitcoinProvider.currentCurrency!.code,
                style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _PriceCurrency(
                    value: bitcoinProvider.priceCOP!,
                    currency: 'COP',
                  ),
                  _PriceCurrency(
                    value: bitcoinProvider.priceEUR!,
                    currency: 'EUR',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PriceCurrency extends StatelessWidget {
  const _PriceCurrency({
    required this.value,
    required this.currency,
  });

  final String value;
  final String currency;

  final textStyle = const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 20,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '\$$value',
          style: textStyle,
        ),
        const SizedBox(height: 5),
        Text(
          currency,
          style: textStyle.copyWith(fontSize: 15),
        )
      ],
    );
  }
}
