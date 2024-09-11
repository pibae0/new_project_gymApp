import 'package:flutter/material.dart';
import 'package:gym_app_project/modules/clients/clients.dart';
import 'package:gym_app_project/modules/clients/widgets/client_list_view.dart';
import 'package:gym_app_project/modules/clients/widgets/search_client.dart';
import 'package:gym_app_project/modules/home/widgets/custom_textfield.dart';

import 'package:gym_app_project/widgets/buttons/custom_icon_button.dart';

class ClientsHomePage extends StatefulWidget {
  const ClientsHomePage({super.key});

  @override
  State<ClientsHomePage> createState() => _ClientsHomePageState();
}

class _ClientsHomePageState extends State<ClientsHomePage> {
  final TextEditingController searchController = TextEditingController();
  // Fazendo as filtragem da busca pelo nome
  List<ClientsBasicInfo> _allClients = [];
  List<ClientsBasicInfo> _filteredClient = [];

  @override
  void initState() {
    super.initState();
    getClients();
  }

  Future<void> getClients() async {
    // final clients = await ClientRepository.fetchClients();
    try {
      final clients = await searchClients('');
      setState(() {
        _filteredClient = clients;
        _allClients = clients;
      });
    } catch (e) {
      print('Error fetching clients: $e');
    }
  }

  void _filterClients(String query) async {
    setState(() {
      _filteredClient = _allClients
          .where((client) =>
              client.name!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: backgroundColors,
      body: Column(
        children: [
          const SizedBox(
            height: 18,
          ),
          // const Padding(padding: EdgeInsets.only(top: 18)),
          SizedBox(
            width: 800,
            child: CustomTextField(
              maxLength: 45,
              suffix: CustomIconButton(
                onTap: () => _filterClients(searchController.text),
                icon: Icons.search,
              ),
              hintText: '     Busque Pelo Aluno',
              controller: searchController,
              onChanged: _filterClients,
            ),
          ),
          // const SizedBox(height: 16),
          Expanded(
            child: ClientListView(clients: _filteredClient),
          ),
          // const SizedBox(height: 24),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   children: [
          //     // TODO : Fazer um Icon Button
          //     CustomButton(
          //       // onPressed: () => context.push('/clients/register'),
          //       onPressed: () {},
          //       padding: const EdgeInsets.symmetric(
          //         vertical: 10,
          //         horizontal: 20,
          //       ),
          //       text: 'Cadastrar',
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
