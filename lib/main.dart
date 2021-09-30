// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter_bitcoin/pages/bitcoin_list_page.dart';
import 'package:flutter_bitcoin/pages/details_page.dart';
import 'package:flutter_bitcoin/providers/bitcoin_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => BitcoinProvider())],
      child: MaterialApp(
        title: 'Bitcoin App',
        debugShowCheckedModeBanner: false,
        initialRoute: 'list-bitcoint',
        routes: {
          "list-bitcoint": (_) => BitcoinListPage(),
          "details": (_) => DetailPage()
        },
      ),
    );
  }
}
