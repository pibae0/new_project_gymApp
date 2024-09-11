import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gym_app_project/utils/snackbar_utils.dart';

import 'package:intl/intl.dart';

class FileService {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController discrebController = TextEditingController();
  final TextEditingController consController = TextEditingController();

  bool fieldsNotEmpty = false;

  // Arquivos selecionados
  File? _selectedFiled;
  // Diretorios selecionado
  String _selectedDirectory = '';

  void saveContent(context) async {
    final title = titleController.text;
    final description = discrebController.text;
    final tag = consController.text;

    final textContent =
        "Titulo:\n\n$title\n\nDescrição:\n\n$description\n\nTags:\n\n$tag";

    try {
      if (_selectedFiled != null) {
        // verificando se o arquivo ja existe
        //se exisste ria reescrever o contexto do arquivo novo
        await _selectedFiled!.writeAsString(textContent);
      } else {
        // Pegando O dia de hoje; Funcao logo abaixo
        //Criando um Arquivo para ser salvo
        final todayDate = getTodayDate();
        String metadataDirPath = _selectedDirectory;
        if (metadataDirPath.isEmpty) {
          final diretory = await FilePicker.platform.getDirectoryPath();
          _selectedDirectory = metadataDirPath = diretory!;
        }
        // ex: c:/user/desktop/2024/07/17 - title - metadata.txt
        final filePath = '$metadataDirPath/$todayDate - $title - Metadata.text';
        final newFile = File(filePath);
        await newFile.writeAsString(textContent);
      }
      SnackBarUtils.showSnackbar(
          context, Icons.check_circle, 'Arquivo salvo com sucesso');
    } catch (e) {
      SnackBarUtils.showSnackbar(
          context, Icons.error, 'Arquivos nao foi salvo \n $e');
    }
  }

  void loadFile(context) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null) {
        File file = File(result.files.single.path!);
        _selectedFiled = file;

        final fileContent = await file.readAsString();

        final lines = fileContent.split('\n\n');
        titleController.text = lines[1];
        discrebController.text = lines[3];
        consController.text = lines[5];
        SnackBarUtils.showSnackbar(
            context, Icons.upload_file, 'Arquivo selecinado');
      } else {
        SnackBarUtils.showSnackbar(
            context, Icons.error_rounded, 'Nenhum arquivo selecionado');
      }
    } catch (e) {
      SnackBarUtils.showSnackbar(
          context, Icons.error_rounded, 'Nenhum arquivo selecionado');
    }
  }

  // Novo Arquivo (Limpando Campos)
  void newFile(context) {
    if (titleController.text.isEmpty ||
        discrebController.text.isEmpty ||
        consController.text.isEmpty) {
      cleanFile(context);
      SnackBarUtils.showSnackbar(
          context, Icons.upload_file, 'Arquivo foi limpo');
    } else {
      cleanFile(context);
      SnackBarUtils.showSnackbar(
          context, Icons.file_upload, 'Novo arquivo criado');
    }
  }

  // Limpeza
  void cleanFile(context) {
    _selectedFiled = null;
    titleController.clear();
    discrebController.clear();
    consController.clear();
  }

  //trocando de diretorio para arquivos
  void newDiretory(context) async {
    try {
      String? diretory = await FilePicker.platform.getDirectoryPath();

      _selectedDirectory = diretory!;
      _selectedFiled = null;
      SnackBarUtils.showSnackbar(
          context, Icons.folder, 'Novo Arquivo selecionado');
    } catch (e) {
      SnackBarUtils.showSnackbar(
          context, Icons.error_rounded, 'Arquivo nao foi selecionado');
    }
  }

  // Configurando o formacato do dia
  static String getTodayDate() {
    final now = DateTime.now();
    // Pacote para formatar(Dar o formato) Date() do Dart
    final formatter = DateFormat('yyyy-MM-dd');
    final formattedDate = formatter.format(now);
    return formattedDate;
  }
}
