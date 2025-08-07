import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  bool _isAuthenticated = false;
  bool _isLoading = false;
  String? _error;
  String? _userEmail;
  String? _userName;

  bool get isAuthenticated => _isAuthenticated;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isAdmin => _userEmail == 'admin@motiapp.com';
  String? get userEmail => _userEmail;
  String? get userName => _userName;

  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      // Simulación de login
      await Future.delayed(const Duration(seconds: 1));
      
      if (email == 'admin@motiapp.com' && password == 'admin123') {
        _isAuthenticated = true;
        _userEmail = email;
        _userName = 'Administrador';
      } else if (email == 'user@motiapp.com' && password == 'user123') {
        _isAuthenticated = true;
        _userEmail = email;
        _userName = 'Usuario';
      } else {
        _error = 'Credenciales incorrectas';
        return false;
      }
      
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _error = 'Error de autenticación';
      notifyListeners();
      return false;
    }
  }

  Future<bool> createUserWithEmailAndPassword(String email, String password, String name) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      // Simulación de registro
      await Future.delayed(const Duration(seconds: 1));
      
      _isAuthenticated = true;
      _userEmail = email;
      _userName = name;
      
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _error = 'Error al crear cuenta';
      notifyListeners();
      return false;
    }
  }

  Future<void> signOut() async {
    try {
      _isAuthenticated = false;
      _userEmail = null;
      _userName = null;
      notifyListeners();
    } catch (e) {
      _error = 'Error al cerrar sesión';
      notifyListeners();
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
} 