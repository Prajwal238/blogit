// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'form_bloc.dart';

abstract class FormState extends Equatable {
  const FormState();

  @override
  List<Object?> get props => [];
}

class FormInitial extends FormState {
  @override
  List<Object> get props => [];
}

class FormsValidate extends FormState {

  final String email;
  final String? displayName;
  final int age;
  final String password;
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isFormValid;
  final bool isNameValid;
  final bool isAgeValid;
  final bool isFormValidateFailed;
  final bool isLoading;
  final String errorMessage;
  final bool isFormSuccessful;
  final bool forgotPassword;

  const FormsValidate(
      {required this.email,
      required this.password,
      required this.isEmailValid,
      required this.isPasswordValid,
      required this.isFormValid,
      required this.isLoading,
      this.errorMessage = "",
      required this.isNameValid,
      required this.isAgeValid,
      required this.isFormValidateFailed,
      this.displayName,
      required this.age,
      this.isFormSuccessful = false,
      this.forgotPassword = false});

  FormsValidate copyWith({
    String? email,
    String? displayName,
    int? age,
    String? password,
    bool? isEmailValid,
    bool? isPasswordValid,
    bool? isFormValid,
    bool? isNameValid,
    bool? isAgeValid,
    bool? isFormValidateFailed,
    bool? isLoading,
    String? errorMessage,
    bool? isFormSuccessful,
    bool? forgotPassword,
  }) {
    return FormsValidate(
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      age: age ?? this.age,
      password: password ?? this.password,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isFormValid: isFormValid ?? this.isFormValid,
      isNameValid: isNameValid ?? this.isNameValid,
      isAgeValid: isAgeValid ?? this.isAgeValid,
      isFormValidateFailed: isFormValidateFailed ?? this.isFormValidateFailed,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      isFormSuccessful: isFormSuccessful ?? this.isFormSuccessful,
      forgotPassword: forgotPassword ?? this.forgotPassword
    );
  }
  @override
  List<Object?> get props => [
        email,
        password,
        isEmailValid,
        isPasswordValid,
        isFormValid,
        isLoading,
        errorMessage,
        isNameValid,
        displayName,
        age,
        isFormValidateFailed,
        isFormSuccessful,
        forgotPassword
      ];
}
