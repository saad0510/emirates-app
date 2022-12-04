class FormValidations {
  static const emailError = "Enter a valid email";
  static const nameError = "Enter atleast 4 characters";
  static const passError = "Enter a password of atleast 6 characters";

  static final emailRegex = RegExp(r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$");

  static String? name(String? text) {
    if (text == null) return null;
    return text.length >= 4 ? null : nameError;
  }

  static String? email(String? text) {
    if (text == null) return null;
    return emailRegex.hasMatch(text) ? null : emailError;
  }

  static String? password(String? text) {
    if (text == null) return null;
    return text.length >= 6 ? null : passError;
  }
}
