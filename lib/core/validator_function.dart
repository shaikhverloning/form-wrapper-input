import 'dart:async';

import 'package:iban/iban.dart';

typedef ValidatorFunction = FutureOr<ValidationResult> Function(dynamic value);

class ValidationResult {
  final bool isValid;
  final String? message;

  ValidationResult({required this.isValid, this.message});
}

Future<ValidationResult> requiredValidator(dynamic value) async {
  if (value == null || (value is String && value.trim().isEmpty)) {
    return ValidationResult(isValid: false, message: 'Field is required');
  }
  return ValidationResult(isValid: true);
}

Future<ValidationResult> maxNumberValidator(dynamic value, num max) async {
  if (value is num && value > max) {
    return ValidationResult(isValid: false, message: 'Maximum number is $max');
  }
  return ValidationResult(isValid: true);
}

Future<ValidationResult> minNumberValidator(dynamic value, num min) async {
  if (value is num && value < min) {
    return ValidationResult(isValid: false, message: 'Minimum number is $min');
  }
  return ValidationResult(isValid: true);
}

Future<ValidationResult> minLengthValidator(dynamic value, int min) async {
  if (value is String && value.length < min) {
    return ValidationResult(isValid: false, message: 'Minimum length is $min');
  }
  return ValidationResult(isValid: true);
}

Future<ValidationResult> maxLengthValidator(dynamic value, int max) async {
  if (value is String && value.length > max) {
    return ValidationResult(isValid: false, message: 'Maximum length is $max');
  }
  return ValidationResult(isValid: true);
}

Future<ValidationResult> selectValidator(dynamic value) async {
  if (value == null || value.toString().isEmpty) {
    return ValidationResult(isValid: false, message: 'Please select an option');
  }
  return ValidationResult(isValid: true);
}

RegExp emailRegex = RegExp(
  r"^[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?$",
);

Future<ValidationResult> emailValidator(dynamic value) async {
  if (value is String && !emailRegex.hasMatch(value)) {
    return ValidationResult(isValid: false, message: 'Invalid email');
  }
  return ValidationResult(isValid: true);
}

Future<ValidationResult> ibanValidator(dynamic value) async {
  if (value is String && !isValid(value)) {
    return ValidationResult(isValid: false, message: 'Invalid IBAN');
  }
  return ValidationResult(isValid: true);
}

Future<ValidationResult> equalTo(dynamic value, dynamic compareValue) async {
  if (value != compareValue) {
    return ValidationResult(isValid: false, message: 'Values do not match');
  }
  return ValidationResult(isValid: true);
}

Future<ValidationResult> isBefore(dynamic value, DateTime compareDate) async {
  if (value is DateTime && value.isAfter(compareDate)) {
    return ValidationResult(
      isValid: false,
      message: 'Date must be before ${compareDate.toLocal()}',
    );
  }
  return ValidationResult(isValid: true);
}

Future<ValidationResult> isAfter(dynamic value, DateTime compareDate) async {
  if (value is DateTime && value.isBefore(compareDate)) {
    return ValidationResult(
      isValid: false,
      message: 'Date must be after ${compareDate.toLocal()}',
    );
  }
  return ValidationResult(isValid: true);
}

Future<ValidationResult> fileExtensionValidator(
  dynamic value,
  List<String> validExtensions,
) async {
  if (value is String) {
    String extension = value.split('.').last;
    if (!validExtensions.contains(extension)) {
      return ValidationResult(
        isValid: false,
        message: 'Invalid file extension',
      );
    }
  }
  return ValidationResult(isValid: true);
}

Future<ValidationResult> fileSizeValidator(
  dynamic value,
  int maxSizeInBytes,
) async {
  if (value is String) {
    // value is file path
    int fileSize = 0;
    if (fileSize > maxSizeInBytes) {
      return ValidationResult(
        isValid: false,
        message: 'File size exceeds ${maxSizeInBytes / 1024} KB',
      );
    }
  }
  return ValidationResult(isValid: true);
}
