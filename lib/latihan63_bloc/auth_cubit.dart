import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const Unauthenticated());

  
  Future<void> cekSesi() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('email');
    if (email != null && email.isNotEmpty) {
      emit(Authenticated(nama: 'Admin HR', email: email));
    }
  }

 
  Future<void> login(String email, String password) async {
    emit(const AuthLoading());
    await Future.delayed(const Duration(seconds: 2));
    if (isClosed) return;

    if (email == 'admin@company.com' && password == 'admin123') {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('email', email);
      emit(const Authenticated(nama: 'Admin HR', email: 'admin@company.com'));
    } else {
      emit(const AuthError('Email atau password salah'));
    }
  }

  
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('email');
    emit(const Unauthenticated());
  }
}