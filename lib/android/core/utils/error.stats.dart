enum ErrorStatus {
  socketException(label: 'Falhou a conexão'),
  httpException(label: 'Servidor está com problemas, tente mais tarde'),
  formatException(label: 'Verifique se o aplicativo tá atualizado'),
  generalException(label: 'Ocorreu um erro, reinicie o aplicativo'),
  unauthorized(label: 'Usuário não autorizado'),
  notFound(label: 'Não encontrado'),
  ;

  final String label;

  const ErrorStatus({required this.label});
}
