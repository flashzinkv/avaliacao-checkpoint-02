import 'package:flutter/material.dart';
import 'package:usedev_uninassau/src/models/cart_item.dart';
import 'package:usedev_uninassau/src/models/product.dart';

class CartController extends ChangeNotifier {
  final List<CartItemModel> _items = [];

  List<CartItemModel> get items => List.unmodifiable(_items);

  bool get isEmpty => _items.isEmpty;

  int get totalProducts =>
      _items.fold(0, (total, item) => total + item.quantity);

  double get subtotal => _items.fold(
        0,
        (total, item) => total + (item.unitPrice * item.quantity),
      );

  double shipping = 0;

  double get total => subtotal + shipping;

  void addItem({
    required Product product,
    required int quantity,
    required String size,
  }) {
    final existingIndex = _items.indexWhere(
      (item) => item.product.id == product.id && item.size == size,
    );

    if (existingIndex >= 0) {
      _items[existingIndex].quantity += quantity;
    } else {
      _items.add(
        CartItemModel(
          product: product,
          quantity: quantity,
          size: size,
        ),
      );
    }

    notifyListeners();
  }

  void updateQuantity(int index, int quantity) {
    if (index < 0 || index >= _items.length) return;
    _items[index].quantity = quantity;
    notifyListeners();
  }

  void updateSize(int index, String size) {
    if (index < 0 || index >= _items.length) return;
    _items[index].size = size;
    notifyListeners();
  }

  void removeAt(int index) {
    if (index < 0 || index >= _items.length) return;
    _items.removeAt(index);
    notifyListeners();
  }
}

class CartScope extends InheritedNotifier<CartController> {
  const CartScope({
    required CartController controller,
    required super.child,
    super.key,
  }) : super(notifier: controller);

  static CartController of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<CartScope>();
    assert(scope != null, 'CartScope not found in widget tree');
    return scope!.notifier!;
  }
}
