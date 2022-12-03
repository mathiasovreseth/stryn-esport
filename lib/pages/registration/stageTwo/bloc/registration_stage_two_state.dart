import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:stryn_esport/pages/loginPage/utils/validation_config.dart';

class RegistrationStageTwoState extends Equatable {
  const RegistrationStageTwoState({
    this.firstName = const Name.pure(),
    this.lastName = const Name.pure(),
    this.phoneNumber = const PhoneNumber.pure(),
    this.age,
    this.address = const Address.pure(),
    this.postNumber = const PostNumber.pure(),
    this.status = FormzStatus.pure,
    this.errorMessage,
  });

  final Name firstName;
  final Name lastName;
  final PhoneNumber phoneNumber;
  final DateTime? age;
  final Address address;
  final PostNumber postNumber;
  final FormzStatus status;
  final String? errorMessage;

  @override
  List<Object> get props => [
        firstName,
        lastName,
        phoneNumber,
        age ?? DateTime.now(),
        address,
        postNumber,
        status
      ];

  RegistrationStageTwoState copyWith({
    Name? firstName,
    Name? lastName,
    PhoneNumber? phoneNumber,
    DateTime? age,
    Address? address,
    PostNumber? postNumber,
    FormzStatus? status,
    String? errorMessage,
  }) {
    return RegistrationStageTwoState(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      age: age ?? this.age,
      address: address ?? this.address,
      postNumber: postNumber ?? this.postNumber,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
