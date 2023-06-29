class Validators {
  static String? validateEmail(String? text) {
    if (text == null || text.isEmpty) {
      return 'Błędny adres email. Spróbuj ponownie!';
    }

    final bool emailValid = RegExp(
            r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
        .hasMatch(text);

    if (emailValid == false) {
      return 'Błędny adres email. Spróbuj ponownie!';
    }

    return null;
  }

  static String? validatePassword(String? text) {
    if (text == null || text.isEmpty) {
      return 'Błędne hasło. Spróbuj ponownie.';
    }

    if (text.length < 6) {
      return 'Hasło musi mieć conajmniej 6 znaków.';
    }

    return null;
  }

  static String? validateUserData(String? text) {
    if (text == null || text.isEmpty) {
      return 'Błędne imie i nazwisko. Spróbuj ponownie!';
    }
    final bool userDataValid =
        RegExp(r"^[a-zA-Z]{4,}(?: [a-zA-Z]+){0,2}$").hasMatch(text);

    if (userDataValid == false) {
      return 'Błędne imie i nazwisko. Spróbuj ponownie!';
    }

    return null;
  }

  static String? validatePhoneNumber(String? text) {
    if (text == null || text.isEmpty) {
      return 'Błędny numer telefonu. Spróbuj ponownie!';
    }

    final phone = text.replaceAll(' ', '');

    final bool phoneValid = RegExp(
            r"\+(9[976]\d|8[987530]\d|6[987]\d|5[90]\d|42\d|3[875]\d|2[98654321]\d|9[8543210]|8[6421]|6[6543210]|5[87654321]|4[987654310]|3[9643210]|2[70]|7|1)\d{1,14}$")
        .hasMatch(phone);

    if (phoneValid == false) {
      return 'Błędny numer telefonu. Spróbuj ponownie!';
    }

    return null;
  }
}
