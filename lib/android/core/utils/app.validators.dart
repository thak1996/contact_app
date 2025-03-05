class AppValidators {
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira o nome';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira o email';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return 'Por favor, insira um email válido';
    }
    return null;
  }

  static String? validateGender(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira o gênero';
    }
    return null;
  }

  static String? validateStatus(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira o status';
    }
    return null;
  }
}
