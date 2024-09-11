class CpfFormatter {
  static String format(String cpf) {
    final text = cpf.replaceAll(
        RegExp(r'\D'), ''); // Remove todos os caracteres não numéricos
    final buffer = StringBuffer();

    for (int i = 0; i < text.length; i++) {
      if (i == 3 || i == 6) buffer.write('.');
      if (i == 9) buffer.write('-');
      buffer.write(text[i]);
    }

    return buffer.toString();
  }
}
