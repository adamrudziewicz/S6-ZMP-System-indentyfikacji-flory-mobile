class PasswordStrength {
  final bool hasMinLength;
  final bool hasUppercase;
  final bool hasLowercase;
  final bool hasNumber;
  final bool hasSpecialChar;

  const PasswordStrength({
    required this.hasMinLength,
    required this.hasUppercase,
    required this.hasLowercase,
    required this.hasNumber,
    required this.hasSpecialChar,
  });

  bool get isValid => hasMinLength && hasUppercase && hasLowercase && hasNumber && hasSpecialChar;
}

class PasswordValidator {
  static PasswordStrength validate(String password) {
    return PasswordStrength(
      hasMinLength: password.length >= 8,
      hasUppercase: password.contains(RegExp(r'[A-Z]')),
      hasLowercase: password.contains(RegExp(r'[a-z]')),
      hasNumber: password.contains(RegExp(r'[0-9]')),
      hasSpecialChar: password.contains(RegExp(r'[!@#\$%\^&\*\(\)_\+\-\=\[\]\{\};:"\\|,.<>\/?]')),
    );
  }
}
