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
        ),
        centerTitle: true,
      ),
      body: bitcoinProvider.prices.isNotEmpty
          ? ListView.builder(
              itemCount: bitcoinProvider.prices.length,
              itemBuilder: (_, int index) {
                return _ListPricesBitcoin(
                  price: bitcoinProvider.prices[index],
                );
              })
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

class _ListPricesBitcoin extends StatelessWidget {
  _ListPricesBitcoin({
    required this.price,
    Key? key,
  }) : super(key: key);

  final PriceListBitcoinDates price;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      leading: const Image(
        image: AssetImage('assets/bitcoin.png'),
        height: 40,
      ),
      title: Text(
        '\$${price.price.ceil()}',
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
      subtitle: Text(
        price.formatDate,
        style: const TextStyle(color: Colors.blueGrey, fontSize: 15),
      ),
    );
  }
}
