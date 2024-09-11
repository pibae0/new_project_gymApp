class DateConvertorAge {
  //Metodo para converter string de adata de nascimento e calcular sua idade (YYYY/MM/DD)
  // static int calcularIdade(String dataNacimento) {
  //   DateTime nascimento = DateTime.parse(dataNacimento);
  //   DateTime diaHoje = DateTime.now();
  //   int idade = diaHoje.year - nascimento.year;
  //
  //   if (diaHoje.month < nascimento.month ||
  //       (diaHoje.month == nascimento.month && diaHoje.day < nascimento.day)) {
  //     idade--;
  //   }
  //   return idade;
  // }

// Metodo para converter o DATE (dd/mm/yyyy) para (yyyy/mm/dd)
  static int calcularIdadeComFormatacao(String dataNascimento) {
    // List<String> partes = dataNascimento.split('/');
    // int dia = int.parse(partes[0]);
    // int mes = int.parse(partes[1]);
    // int ano = int.parse(partes[2]);
    var formattedDate = dataNascimento;

    if (dataNascimento.contains('/')) {
      formattedDate = dataNascimento.split('/').reversed.join('-');
    }

    DateTime nascimento = DateTime.parse(formattedDate);
    DateTime hoje = DateTime.now();
    int idade = hoje.year - nascimento.year;
    if (hoje.month < nascimento.month ||
        (hoje.month == nascimento.month && hoje.day < nascimento.day)) {
      idade--;
    }
    return idade;
  }
}
