import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bitcoin/models/currency.dart';
import 'package:flutter_bitcoin/models/price_list_bitcoin.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class BitcoinProvider extends ChangeNotifier {
  final String _baseUrl = 'api.coindesk.com';
  final String _currenPrice = '/v1/bpi/currentprice.json';
  final String _priceList = '/v1/bpi/historical/close.json';
  final String _priceCop = '/v1/bpi/currentprice/COP.json';
  final String _priceEur = '/v1/bpi/currentprice/EUR.json';
  final String _endpointConvert = 'free.currencyconverterapi.com';
  final String _apiKey = '0ade467a2d5d275185eb';
  List<PriceListBitcoinDates> prices = [];
  Currency? currentCurrency;
  String? selectedPrice;
  String? priceCOP;
  String? priceEUR;

  BitcoinProvider() {
    getListPriceBitcoin();
    getCurrentPricebtn();
    // Timer.periodic(const Duration(milliseconds: 100), (t) {
    //   getCurrentPricebtn();
    // });
    // convertcurrency();
  }

  Future<String> _getJsonData(String endpoint) async {
    final url = Uri.https(_baseUrl, endpoint);

    final response = await http.get(url);
    return response.body;
  }

  getListPriceBitcoin() async {
    var formatter = DateFormat('yyyy-MM-dd');
    var dateNow = DateTime.now();
    var lastDate = DateTime(dateNow.year, dateNow.month, dateNow.day - 14);

    var url = Uri.https(_baseUrl, _priceList, {
      'start': formatter.format(lastDate),
      'end': formatter.format(dateNow)
    });
    var response = await http.get(url);

    final decodeData = json.decode(response.body);

    await decodeData['bpi'].forEach((k, v) {
      prices.add(PriceListBitcoinDates(date: k, price: v));
    });
    prices = prices.reversed.toList();
    notifyListeners();
    // return decodeData['bpi'];
  }

  getCurrentPricebtn() async {
    var response = await _getJsonData(_currenPrice);

    final decodeData = json.decode(response);

    currentCurrency = Currency.fromJson(decodeData['bpi']['USD']);
    notifyListeners();
  }

  getPriceCopbtn() async {
    var response = await _getJsonData(_priceCop);

    final decodeData = json.decode(response);

    priceCOP = Currency.fromJson(decodeData['bpi']['COP']).rate;
    notifyListeners();
  }

  getPriceEurbtn() async {
    var response = await _getJsonData(_priceEur);

    final decodeData = json.decode(response);

    priceEUR = Currency.fromJson(decodeData['bpi']['EUR']).rate;
    notifyListeners();
  }

  convertcurrency() async {
    final url = Uri.https(_endpointConvert, '/api/v5/convert', {
      "q": "USD_EUR,USD_COP",
      "compact": "ultra",
      "apiKey": "0ade467a2d5d275185eb"
    });
    print(url);

    final response = await http.get(url);
    print(response.body);

    final decodeData = json.decode(response.body);
    print(decodeData['USD_COP']);

    print(double.parse(selectedPrice!));

    final convertCop =
        decodeData['USD_COP'].toDouble() * double.parse(selectedPrice!);
    priceCOP = convertCop.toString();
    print(priceCOP);
    final convertEur =
        decodeData['USD_EUR'].toDouble() * double.parse(selectedPrice!);
    priceEUR = convertEur.toString();
    print(priceEUR);
  }
}
