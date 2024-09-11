import 'package:intl/intl.dart';

String? validateDate(String? value) {
  if (value == null || value.isEmpty) {
    return 'Campo obrigatório';
  }
  final RegExp dateRegExp = RegExp(r'^\d{2}/\d{2}/\d{4}$');
  if (!dateRegExp.hasMatch(value)) {
    return 'Formato da data de nascimento incorreto';
  }
  return null;
}

String convertDate(String date) {
  if (date.isEmpty) {
    throw const FormatException('Data de nascimento vazia');
  }

  final inputFormat = DateFormat('dd/MM/yyyy');
  final outputFormat = DateFormat('yyyy-MM-dd');
  try {
    final DateTime dateTime = inputFormat.parse(date);
    return outputFormat.format(dateTime);
  } catch (e) {
    throw FormatException('Formato de data inválido: $date');
  }
}
