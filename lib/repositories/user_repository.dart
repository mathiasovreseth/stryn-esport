import 'package:stryn_esport/models/user_model.dart';


/// Repository that manages the user accounts.
abstract class UserRepository {
  Future<bool> editUser({required UpdatedUser updatedUser});
}
