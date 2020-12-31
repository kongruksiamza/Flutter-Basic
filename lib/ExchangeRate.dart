import 'dart:convert';

ExchangeRate exchangeRateFromJson(String str) => ExchangeRate.fromJson(json.decode(str));

String exchangeRateToJson(ExchangeRate data) => json.encode(data.toJson());

class ExchangeRate {
    ExchangeRate({
        this.rates,
        this.base,
        this.date,
    });

    Map<String, double> rates;
    String base;
    DateTime date;

    factory ExchangeRate.fromJson(Map<String, dynamic> json) => ExchangeRate(
        rates: json["rates"] == null ? null : Map.from(json["rates"]).map((k, v) => MapEntry<String, double>(k, v.toDouble())),
        base: json["base"] == null ? null : json["base"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
    );

    Map<String, dynamic> toJson() => {
        "rates": rates == null ? null : Map.from(rates).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "base": base == null ? null : base,
        "date": date == null ? null : "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    };
}
