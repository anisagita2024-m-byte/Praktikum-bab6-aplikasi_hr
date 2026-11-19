import 'package:equatable/equatable.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}
class Unauthenticated extends AuthState {
  const Unauthenticated();
}
class AuthLoading extends AuthState {
  const AuthLoading();
} 
class Authenticated extends AuthState {
  final String nama;
  final String email;
  const Authenticated({required this.nama, required this.email});

  @override
  List<Object?> get props => [nama, email];
}
class AuthError extends AuthState {
  final String pesan;
  const AuthError(this.pesan);

  @override
  List<Object?> get props => [pesan];
}