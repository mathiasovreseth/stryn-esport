import 'package:stryn_esport/models/user_model.dart';

abstract class UserRepository {
  Future<bool> editUser({required UpdatedUser updatedUser});
}
