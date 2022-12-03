import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stryn_esport/models/user_model.dart';
import 'package:stryn_esport/repositories/user_repository.dart';
import 'package:stryn_esport/services/api_path.dart';

class FirebaseUserRepository extends UserRepository {
  @override
  Future<bool> editUser({required UpdatedUser updatedUser}) async {
    try {
      await FirebaseFirestore.instance
          .collection(APIPath.users())
          .doc(updatedUser.id)
          .update({
        "firstName": updatedUser.firstName,
        "lastName": updatedUser.lastName,
        "phoneNumber": updatedUser.phoneNumber,
        "birthDate": updatedUser.age,
        "address": updatedUser.address,
        "postNumber": updatedUser.postNumber,
      });
      return true;
    } on FirebaseException catch(e) {
      // TODO Do we get any error codes?
      return false;
    }

  }
}
