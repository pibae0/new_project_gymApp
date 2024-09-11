import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gym_app_project/modules/clients/clients.dart';
import 'package:gym_app_project/modules/clients/service/client_service.dart';
import 'package:gym_app_project/modules/clients/widgets/date_convertor_age.dart';
import 'package:gym_app_project/utils/const_colors.dart';
import 'package:gym_app_project/utils/snackbar_utils.dart';

class ClientsPerfilPage extends StatefulWidget {
  final ClientsBasicInfo client;

  const ClientsPerfilPage({
    super.key,
    required this.client,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ClientsPerfilPageState createState() => _ClientsPerfilPageState();
}

class _ClientsPerfilPageState extends State<ClientsPerfilPage> {
  bool isEditingName = false;
  bool isEditingObjetivo = false;
  bool isEditingFrequencia = false;
  bool isEditingDataNascimento = false;

  late TextEditingController nameController;
  late TextEditingController objetivoController;
  late TextEditingController frequenciaController;
  late TextEditingController dataNascimentoController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.client.name);
    objetivoController = TextEditingController(text: widget.client.objetivo);
    frequenciaController =
        TextEditingController(text: widget.client.frequencia.toString());
    dataNascimentoController =
        TextEditingController(text: widget.client.dataNascimento);
  }

  @override
  void dispose() {
    nameController.dispose();
    objetivoController.dispose();
    frequenciaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final int idade = DateConvertorAge.calcularIdadeComFormatacao(
        widget.client.dataNascimento);

    return Scaffold(
      backgroundColor: AppTheme.medium,
      appBar: AppBar(
        title: const Text('Perfil do Aluno'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 100,
                    backgroundImage: widget.client.imagePath != null
                        ? NetworkImage(widget.client.imagePath!)
                        : null,
                    child: widget.client.imagePath == null
                        ? const Icon(Icons.person, size: 100)
                        : null,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    // Use Expanded aqui para permitir que os textos se ajustem corretamente ao layout
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        _buildEditableRow(
                          label: 'Nome ',
                          isEditing: isEditingName,
                          controller: nameController,
                          style: const TextStyle(fontSize: 18),
                          onEditPressed: ({
                            required bool isEditing,
                            required VoidCallback toggleEditing,
                            required Future<void> Function() updateClient,
                            required String newValue,
                            required String oldValue,
                          }) async {
                            await _handleEdit(
                              isEditing: isEditing,
                              toggleEditing: toggleEditing,
                              updateClient: updateClient,
                              newValue: newValue,
                              oldValue: widget
                                  .client.name!, // or the correct old value
                            );
                          },
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Idade : $idade",
                          style: const TextStyle(
                              fontSize: 16, color: Colors.white),
                        ),
                        const SizedBox(height: 8),
                        _buildEditableRow(
                          label: 'Objetivo ',
                          isEditing: isEditingObjetivo,
                          controller: objetivoController,
                          style: const TextStyle(fontSize: 18),
                          onEditPressed: ({
                            required bool isEditing,
                            required VoidCallback toggleEditing,
                            required Future<void> Function() updateClient,
                            required String newValue,
                            required String oldValue,
                          }) async {
                            await _handleEdit(
                              isEditing: isEditing,
                              toggleEditing: toggleEditing,
                              updateClient: updateClient,
                              newValue: newValue,
                              oldValue: widget
                                  .client.objetivo!, // or the correct old value
                            );
                          },
                        ),

                        // onEditPressed: () {
                        //   setState(() {
                        //     isEditingObjetivo = !isEditingObjetivo;
                        //   });
                        //   if (!isEditingObjetivo) {
                        //     ClientService.updateClient(
                        //       widget.client.id.toString(),
                        //       widget.client.copyWith(
                        //           objetivo: objetivoController.text),
                        //     );
                        //   }
                        // },

                        const SizedBox(height: 8),
                        _buildEditableRow(
                          label: 'Frequência ',
                          isEditing: isEditingFrequencia,
                          controller: frequenciaController,
                          style: const TextStyle(fontSize: 18),
                          onEditPressed: ({
                            required bool isEditing,
                            required VoidCallback toggleEditing,
                            required Future<void> Function() updateClient,
                            required String newValue,
                            required String oldValue,
                          }) async {
                            await _handleEdit(
                              isEditing: isEditing,
                              toggleEditing: toggleEditing,
                              updateClient: updateClient,
                              newValue: newValue,
                              oldValue: widget.client.frequencia
                                  .toString(), // or the correct old value
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleEdit({
    required bool isEditing,
    required VoidCallback toggleEditing,
    required Future<void> Function() updateClient,
    required String newValue,
    required String oldValue,
  }) async {
    if (isEditing) {
      toggleEditing();
    } else {
      // Start editing mode
      toggleEditing();
      return;
    }

    if (newValue == oldValue) {
      // No changes made
      return;
    }

    try {
      await updateClient();
      SnackBarUtils.showSnackbar(
          context, Icons.check_box, 'Atualização bem-sucedida!');
    } catch (e) {
      SnackBarUtils.showSnackbar(
          context, Icons.error_outline, 'Erro ao atualizar cliente.');
    }
  }

  Widget _buildEditableRow({
    required String label,
    required bool isEditing,
    required TextEditingController controller,
    required TextStyle style,
    required Future<void> Function({
      required bool isEditing,
      required VoidCallback toggleEditing,
      required Future<void> Function() updateClient,
      required String newValue,
      required String oldValue,
    }) onEditPressed,
  }) {
    return Row(
      children: [
        Text(
          '$label:   ',
          style: style,
        ),
        if (isEditing)
          Expanded(
            child: TextFormField(
              controller: controller,
              style: const TextStyle(fontSize: 16, color: Colors.white),
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                hintText: 'Digite a alteração',
                hintStyle: TextStyle(color: Colors.white60),
              ),
            ),
          )
        else
          Expanded(
            child: Text(controller.text, style: style),
          ),
        IconButton(
          icon: Icon(isEditing ? Icons.check : Icons.edit, color: Colors.white),
          onPressed: () => onEditPressed(
            isEditing: isEditing,
            toggleEditing: () => setState(() {
              // Toggle editing state here
            }),
            updateClient: () async {
              await ClientService.updateClient(
                widget.client.id.toString(),
                widget.client.copyWith(
                  objetivo: controller.text,
                ),
              );
            },
            newValue: controller.text,
            oldValue: controller.text,
          ),
        ),
      ],
    );
  }
}

  // Future<void> _handleEdit({
  //   required bool isEditing,
  //   required VoidCallback toggleEditing,
  //   required Future<void> Function() updateClient,
  // }) async {
  //   if (isEditing) {
  //     toggleEditing();
  //   } else {
  //     // Start editing mode
  //     toggleEditing();
  //     return;
  //   }

  //   try {
  //     await updateClient();
  //     SnackBarUtils.showSnackbar(
  //         context, Icons.check, 'Aluno atualizado com sucesso');
  //   } catch (e) {
  //     SnackBarUtils.showSnackbar(
  //         context, Icons.error_outline, 'Não foi possivel Atualizar o aluno');
  //   }
  // }

//   Widget _buildEditableRow(
//       {String? label,
//       required bool isEditing,
//       required TextEditingController controller,
//       required VoidCallback onEditPressed,
//       required TextStyle style}) {
//     return Row(
//       children: [
//         Text(
//           '$label:   ',
//         ),
//         if (isEditing)
//           Expanded(
//             child: TextFormField(
//               controller: controller,
//               style: const TextStyle(fontSize: 16, color: Colors.white),
//               decoration: const InputDecoration(
//                 border: UnderlineInputBorder(),
//                 hintText: 'Digite a alteração',
//                 hintStyle: TextStyle(color: Colors.white60),
//               ),
//             ),
//           )
//         else
//           Expanded(
//             child: Text(controller.text, style: style),
//           ),
//         IconButton(
//           icon: Icon(isEditing ? Icons.check : Icons.edit, color: Colors.white),
//           onPressed: onEditPressed,
//         ),
//       ],
//     );
//   }
// }
