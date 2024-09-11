import 'dart:convert';
import 'package:gym_app_project/modules/clients/clients.dart';

import 'package:http/http.dart' as http;

class ClientService {
  static const String _baseUrl = 'http://localhost:8000/alunos/';

  // Fetch all clients
  static Future<List<ClientsBasicInfo>> fetchClients() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
      List<ClientsBasicInfo> lista = [];
      for (var client in data) {
        lista.add(ClientsBasicInfo.fromJson(client));
      }
      return lista;
      // return data.map((json) => ClientsBasicInfo.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load clients');
    }
  }

  // Fetch a single client by ID
  static Future<ClientsBasicInfo> fetchClientById(String id) async {
    final response = await http.get(Uri.parse('$_baseUrl$id/'));

    if (response.statusCode == 200) {
      return ClientsBasicInfo.fromJson(json.decode(response.body));
    } else {
      print(
          'Erro ao carregar dados do cliente: ${response.statusCode} - ${response.body}');
      throw Exception('Failed to load client');
    }
  }

  // Add a new client
  static Future<void> addClient(ClientsBasicInfo client) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode({
        'nome': client.name,
        'sexo': client.sexo,
        'cpf': client.alunoCpf,
        'vencimento_plano_treino': client.vencimento,
        'objetivo': client.objetivo,
        'avaliacao': client.avaliacao,
        'email': client.email,
        'data_nascimento': client.dataNascimento,
        'foto': client.imagePath,
        'telefone': client.telefone,
      }),
    );

    if (response.statusCode != 201) {
      print(response.body);
      print(response.statusCode);
      throw Exception('Failed to add client');
    }
  }

  // Update an existing client
  static Future<void> updateClient(String id, ClientsBasicInfo client) async {
    try {
      final response = await http.put(
        Uri.parse('$_baseUrl$id/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          'nome': client.name,
          'sexo': client.sexo,
          'cpf': client.alunoCpf,
          'vencimento_plano_treino': client.vencimento,
          'objetivo': client.objetivo,
          'avaliacao': client.avaliacao,
          'email': client.email,
          'data_nascimento': client.dataNascimento,
          // 'foto': client.imagePath,
          'telefone': client.telefone,
        }),
      );

      if (response.statusCode == 200) {
        print('Client atualizado com sucesso');
      } else {
        print('Erro ao atualizar cliente: ${response.statusCode}');
        print('Resposta: ${response.body}');
      }
    } catch (e) {
      print('Erro ao realizar a requisição: $e');
    }
  }

  // Delete a client
  static Future<void> deleteClient(String id) async {
    final response = await http.delete(Uri.parse('$_baseUrl$id/'));

    if (response.statusCode != 204) {
      throw Exception('Failed to delete client');
    }
  }
}
