// To parse this JSON data, do
//
//     final currenPrice = currenPriceFromJson(jsonString);

import 'dart:convert';

CurrenPrice currenPriceFromJson(String str) =>
    CurrenPrice.fromJson(json.decode(str));

String currenPriceToJson(CurrenPrice data) => json.encode(data.toJson());

class CurrenPrice {
  CurrenPrice({
    required this.time,
    required this.disclaimer,
    required this.chartName,
    required this.bpi,
  });

  String time;
  String disclaimer;
  String chartName;
  Bpi bpi;

  factory CurrenPrice.fromJson(Map<String, dynamic> json) => CurrenPrice(
        time: json["time"],
        disclaimer: json["disclaimer"],
        chartName: json["chartName"],
        bpi: Bpi.fromJson(json["bpi"]),
      );

  Map<String, dynamic> toJson() => {
        "time": time,
        "disclaimer": disclaimer,
        "chartName": chartName,
        "bpi": bpi.toJson(),
      };
}

class Bpi {
  Bpi({
    required this.usd,
    required this.gbp,
    required this.eur,
  });

  Eur usd;
  Eur gbp;
  Eur eur;

  factory Bpi.fromJson(Map<String, dynamic> json) => Bpi(
        usd: Eur.fromJson(json["USD"]),
        gbp: Eur.fromJson(json["GBP"]),
        eur: Eur.fromJson(json["EUR"]),
      );

  Map<String, dynamic> toJson() => {
        "USD": usd.toJson(),
        "GBP": gbp.toJson(),
        "EUR": eur.toJson(),
      };
}

class Eur {
  Eur({
    required this.code,
    required this.symbol,
    required this.rate,
    required this.description,
    required this.rateFloat,
  });

  String code;
  String symbol;
  String rate;
  String description;
  double rateFloat;

  factory Eur.fromJson(Map<String, dynamic> json) => Eur(
        code: json["code"],
        symbol: json["symbol"],
        rate: json["rate"],
        description: json["description"],
        rateFloat: json["rate_float"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "symbol": symbol,
        "rate": rate,
        "description": description,
        "rate_float": rateFloat,
      };
}
