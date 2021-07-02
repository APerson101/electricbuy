import 'dart:convert';

class Power {
  String meter_number;
  String product_code;
  String amount;
  Power({
    this.meter_number,
    this.product_code,
    this.amount,
  });

  Power copyWith({
    String meter_number,
    String product_code,
    String amount,
  }) {
    return Power(
      meter_number: meter_number ?? this.meter_number,
      product_code: product_code ?? this.product_code,
      amount: amount ?? this.amount,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'meter_number': meter_number,
      'product_code': product_code,
      'amount': amount,
    };
  }

  factory Power.fromMap(Map<String, dynamic> map) {
    return Power(
      meter_number: map['meter_number'],
      product_code: map['product_code'],
      amount: map['amount'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Power.fromJson(String source) => Power.fromMap(json.decode(source));

  @override
  String toString() =>
      'Power(meter_number: $meter_number, product_code: $product_code, amount: $amount)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Power &&
        other.meter_number == meter_number &&
        other.product_code == product_code &&
        other.amount == amount;
  }

  @override
  int get hashCode =>
      meter_number.hashCode ^ product_code.hashCode ^ amount.hashCode;
}
