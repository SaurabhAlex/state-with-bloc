
// Regular expression pattern to validate email addresses.
import 'dart:ffi';

const emailValidationPattern =
    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?$";

// Validator method for validating email
bool validateEmailAddress(String? value) {
  if (value!.isEmpty) {
    return false;
  } else if (!RegExp(emailValidationPattern)
      .hasMatch(value)) {
    return false;
  }
  return true;
}

