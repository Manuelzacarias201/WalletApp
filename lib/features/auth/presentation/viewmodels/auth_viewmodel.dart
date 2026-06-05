import 'package:flutter/material.dart';
import '../../data/services/auth_service.dart';
import '../../domain/entities/user_entity.dart';

/// VIEWMODEL DE AUTENTICACIÓN (Presentation Layer)
class AuthViewModel extends ChangeNotifier {
  final AuthService _service;

  AuthViewModel({required AuthService service}) : _service = service;

  // Estados
  UserEntity? _currentUser;
  bool _isLoading = false;
  String? _errorMessage;

  // Getters
  UserEntity? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _currentUser != null;

  /// Método de Login
  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Simulación de delay para feedback visual
      await Future.delayed(const Duration(seconds: 1));
      
      // En una app real, aquí llamaríamos a _service.login
      // Para efectos del ejemplo y que sea funcional sin API real:
      if (email == "user@test.com" && password == "123456") {
        _currentUser = UserEntity(
          id: "1",
          email: email,
          name: "Usuario Demo",
          token: "fake-jwt-token",
        );
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        throw Exception("Credenciales incorrectas (Usa: user@test.com / 123456)");
      }
    } catch (e) {
      _errorMessage = e.toString().replaceAll("Exception: ", "");
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  /// Método de Registro
  Future<bool> register(String name, String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 1));
      // Simulación de registro exitoso
      _currentUser = UserEntity(id: "2", email: email, name: name, token: "token-new");
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  void logout() {
    _currentUser = null;
    notifyListeners();
  }
}
