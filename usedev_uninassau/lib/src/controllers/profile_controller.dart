import 'package:flutter/material.dart';
import 'package:usedev_uninassau/src/models/user.dart';

class ProfileController extends ChangeNotifier {
  User? _user;

  User? get user => _user;

  bool get isLoggedIn => _user != null;

  String? login({
    required String email,
    required String password,
  }) {
    final normalizedEmail = email.trim().toLowerCase();

    if (normalizedEmail.isEmpty || !normalizedEmail.contains('@')) {
      return 'Informe um e-mail válido.';
    }

    if (password.length < 6) {
      return 'A senha deve ter pelo menos 6 caracteres.';
    }

    _user = User(
      name: _nameFromEmail(normalizedEmail),
      email: normalizedEmail,
    );
    notifyListeners();
    return null;
  }

  void logout() {
    _user = null;
    notifyListeners();
  }

  String _nameFromEmail(String email) {
    final localPart = email.split('@').first;
    return localPart
        .split(RegExp(r'[._-]+'))
        .where((part) => part.isNotEmpty)
        .map(
          (part) => '${part[0].toUpperCase()}${part.substring(1).toLowerCase()}',
        )
        .join(' ');
  }
}

class ProfileScope extends InheritedNotifier<ProfileController> {
  const ProfileScope({
    required ProfileController controller,
    required super.child,
    super.key,
  }) : super(notifier: controller);

  static ProfileController of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<ProfileScope>();
    assert(scope != null, 'ProfileScope not found in widget tree');
    return scope!.notifier!;
  }
}
