import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:flutter/foundation.dart';

@immutable //koi bhi field changeable na ho
class AuthUser {
  final bool isEmailVerified;
  const AuthUser({required this.isEmailVerified});
  
  factory AuthUser.fromFirebase(User user) => AuthUser(isEmailVerified: user.emailVerified);
 
}
