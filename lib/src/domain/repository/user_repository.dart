import 'package:pet_style_mobile/src/data/model/user/user.dart';

abstract interface class UserRepository {
  Future<User?> getUserData();
  Future<User?> getUserById(String id);
  Future<bool> isPhoneNumberExist();
  Future<void> updatePhoneNumber(String phoneNumber);
}
