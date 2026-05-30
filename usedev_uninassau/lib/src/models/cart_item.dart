import 'package:usedev_uninassau/src/models/product.dart';

class CartItemModel {
  CartItemModel({
    required this.product,
    this.quantity = 1,
    this.size = 'G',
  });

  final Product product;
  int quantity;
  String size;

  double get unitPrice {
    final normalized = product.price.replaceAll(',', '.');
    return double.tryParse(normalized) ?? 0;
  }

  double get lineTotal => unitPrice * quantity;

  String get formattedPrice => 'R\$ ${unitPrice.toStringAsFixed(0)}';

  String get formattedLineTotal {
    final value = lineTotal.toStringAsFixed(2).replaceAll('.', ',');
    return 'R\$ $value';
  }
}

String formatCurrency(double value) {
  final formatted = value.toStringAsFixed(2).replaceAll('.', ',');
  return 'R\$ $formatted';
}
