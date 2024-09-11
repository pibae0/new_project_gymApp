import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_app_project/modules/clients/clients.dart';
import 'package:gym_app_project/modules/clients/widgets/date_convertor_age.dart';
import 'package:gym_app_project/utils/const_colors.dart';

class ClientListView extends StatelessWidget {
  final List<ClientsBasicInfo> clients;

  const ClientListView({super.key, required this.clients});

  @override
  Widget build(BuildContext context) {
    print(clients);
    return ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          final client = clients[index];
          final int idade = DateConvertorAge.calcularIdadeComFormatacao(
              client.dataNascimento);

          return ListTile(
            minVerticalPadding: 10,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            leading:
                // Container(
                //   width: 100,
                //   height: 100,
                //   child: ClipOval(
                //     child: Container(width: 100, height: 100, color: Colors.white),
                //   ),
                //   color: Colors.red,
                // ),
                Image.network(
              client.imagePath!,
              height: 100,
              fit: BoxFit.cover,
            ),
            title: Text(
              client.name!,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            subtitle: Text(
              '$idade anos',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
            trailing: Text(
              client.frequencia.toString(),
              style: const TextStyle(
                color: AppTheme.accent,
                fontSize: 12,
              ),
            ),
            onTap: () => context.pushNamed('clientsPerfil',
                pathParameters: {'id': client.id.toString()}),
          );
        },
        padding: const EdgeInsets.all(16),
        separatorBuilder: (BuildContext context, int index) => const Divider(
              color: AppTheme.accent,
            ),
        itemCount: clients.length);
  }
}
