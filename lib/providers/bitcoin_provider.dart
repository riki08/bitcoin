import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bitcoin/models/price_list_bitcoin.dart';
import 'package:http/http.dart' as http;

class BitcoinProvider extends ChangeNotifier {
  final String _baseUrl = 'api.coindesk.com';
  final String _currenPrice = '/v1/bpi/currentprice.json';
  final String _priceList = '/v1/bpi/historical/close.json';
  List<PriceListBitcoinDates> prices = [];

  BitcoinProvider() {
    getListPriceBitcoin();
  }

  getListPriceBitcoin() async {
    var url = Uri.https(_baseUrl, _priceList);

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);

    final decodeData = json.decode(response.body);

    await decodeData['bpi'].forEach((k, v) {
      prices.add(PriceListBitcoinDates(date: k, price: v));
      // print(k);
      // print(v);
      // print(decodeData['bpi'][k]);
      // print(decodeData['bpi'][v]);
    });
    print(prices.length);
    notifyListeners();
    // return decodeData['bpi'];
  }
}
