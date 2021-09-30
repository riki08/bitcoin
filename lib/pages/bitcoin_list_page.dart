// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bitcoin/models/price_list_bitcoin.dart';
import 'package:flutter_bitcoin/providers/bitcoin_provider.dart';
import 'package:provider/provider.dart';

// ignore: use_key_in_widget_constructors
class BitcoinListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bitcoinProvider = Provider.of<BitcoinProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Listado de precios',
          style: TextStyle(fontSize: 25),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _CurrentCurrency(bitcoinProvider: bitcoinProvider),
            _ListPriceBitcoin(
                bitcoinProvider: bitcoinProvider) //<< any widgets added
          ],
        ),
      ),
    );
  }
}

class _CurrentCurrency extends StatelessWidget {
  _CurrentCurrency({
    Key? key,
    required this.bitcoinProvider,
  }) : super(key: key);

  final BitcoinProvider bitcoinProvider;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return bitcoinProvider.currentCurrency != null
        ? GestureDetector(
            onTap: () async {
              bitcoinProvider.selectedPrice =
                  bitcoinProvider.currentCurrency!.rate;
              await bitcoinProvider.getPriceCopbtn();
              await bitcoinProvider.getPriceEurbtn();
              Navigator.pushNamed(context, 'details',
                  arguments: bitcoinProvider.currentCurrency!.rate);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              // height: size.height * 0.2,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      'Precio actual BTN',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                  Text(
                    '\$${bitcoinProvider.currentCurrency!.rate} ' +
                        bitcoinProvider.currentCurrency!.code,
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          )
        : SizedBox(
            height: size.height * 0.2,
          );
  }
}

class _ListPriceBitcoin extends StatelessWidget {
  _ListPriceBitcoin({
    Key? key,
    required this.bitcoinProvider,
  }) : super(key: key);

  final BitcoinProvider bitcoinProvider;

  @override
  Widget build(BuildContext context) {
    return bitcoinProvider.prices.isNotEmpty
        ? ListView.builder(
            shrinkWrap: true, // use it
            scrollDirection: Axis.vertical,
            physics: NeverScrollableScrollPhysics(),
            itemCount: bitcoinProvider.prices.length,
            itemBuilder: (_, int index) {
              return _CardBitcoin(
                price: bitcoinProvider.prices[index],
              );
            })
        : Center(
            child: CircularProgressIndicator(),
          );
  }
}

class _CardBitcoin extends StatelessWidget {
  _CardBitcoin({
    required this.price,
  });

  final PriceListBitcoinDates price;

  @override
  Widget build(BuildContext context) {
    final bitcoinProvider = Provider.of<BitcoinProvider>(context);
    return ListTile(
      onTap: () {
        bitcoinProvider.selectedPrice = price.price.toString();
        Navigator.pushNamed(context, 'details');
      },
      leading: const Image(
        image: AssetImage('assets/bitcoin.png'),
        height: 40,
      ),
      title: Text(
        '\$${price.price.ceil()}',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      subtitle: Text(
        price.formatDate,
        style: const TextStyle(color: Colors.grey, fontSize: 15),
      ),
      trailing: Icon(Icons.arrow_forward_ios),
    );
  }
}
