import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_app_project/modules/clients/clients.dart';
import 'package:gym_app_project/modules/clients/pages/clients_perfil_page.dart';
import 'package:gym_app_project/modules/clients/pages/clients_register_page.dart';
import 'package:gym_app_project/modules/clients/service/client_service.dart';

import 'package:gym_app_project/modules/home/pages/homenew_page.dart';

final GoRoute clientRoute = GoRoute(
  path: '/clients',
  name: 'clients',
  builder: (context, state) => const MyHomePage(),
  routes: [
    GoRoute(
      path: 'register',
      name: 'clientRegister',
      builder: (context, state) => const ClientsRegisterPage(),
    ),
    GoRoute(
      path: 'perfil/:id',
      name: 'clientsPerfil',
      builder: (context, state) {
        final String id = state.pathParameters['id']!;

        return FutureBuilder<ClientsBasicInfo>(
          future: ClientService.fetchClientById(id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('Erro ao carregar dados do cliente'),
              );
            } else if (snapshot.hasData) {
              return ClientsPerfilPage(client: snapshot.data!);
            } else {
              return const Center(child: Text('Cliente não encontrado'));
            }
          },
        );
      },
    )
  ],
);
