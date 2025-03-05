class ErrorTranslator {
  static String translate(String field, String message) {
    if (field == 'email' && message == 'is invalid') {
      return 'E-mail inválido';
    }
    if (field == 'email' && message == 'has already been taken') {
      return 'E-mail já cadastrado';
    }
    return '$field: $message';
  }

  static String translateList(List<dynamic> errors) {
    return errors
        .map(
          (error) => translate(error['field'], error['message']),
        )
        .join(' / ');
  }
}
