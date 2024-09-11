class ClientsBasicInfo {
  final int id;
  final String? name;
  final String? sexo;
  final int? frequencia;
  final String? alunoCpf;
  final String? vencimento;
  final String? objetivo;
  final String? avaliacao;
  final String? email;
  final String dataNascimento;
  final String? imagePath;
  final String? telefone;

  ClientsBasicInfo(
      {this.telefone,
      required this.id,
      this.email,
      this.sexo,
      this.avaliacao,
      this.name,
      required this.dataNascimento,
      this.alunoCpf,
      this.vencimento,
      this.objetivo,
      this.frequencia,
      this.imagePath});

  factory ClientsBasicInfo.fromJson(Map<String, dynamic> json) {
    return ClientsBasicInfo(
        dataNascimento: json['data_nascimento'] ?? "25/07/2024",
        id: json['id'],
        email: json['email'] ?? "piveta@hotmail.com",
        sexo: json['sexo'],
        avaliacao: json['avaliacao'],
        name: json['nome'] ?? "Pedro",
        alunoCpf: json['cpf'] ?? "00000000000",
        vencimento: json['vencimento_plano_treino'] ?? "LOL",
        telefone: json['telefone'] ?? "99999999",
        imagePath: json['foto'],
        objetivo: json['objetivo'],
        frequencia: json['frequencia']);
  }

  // factory ClientsBasicInfo.fromMap(Map<String, dynamic> map) {
  //   return ClientsBasicInfo(
  //     dataNascimento: map['data_nascimento'] ?? "25/07/2024",
  //     id: map['id'],
  //     email: map['email'] ?? "piveta@hotmail.com",
  //     sexo: map['sexo'],
  //     avaliacao: map['avaliacao'],
  //     name: map['nome'] ?? "Pedro",
  //     alunoCpf: map['cpf'] ?? "00000000000",
  //     vencimento: map['vencimento_plano_treino'] ?? "LOL",
  //     telefone: map['telefone'] ?? "99999999",
  //     imagePath: map['foto'],
  //   );
  // }

  ClientsBasicInfo copyWith({
    String? name,
    String? sexo,
    int? frequencia,
    String? alunoCpf,
    String? vencimento,
    String? objetivo,
    String? avaliacao,
    String? email,
    String? dataNascimento,
    String? imagePath,
    String? telefone,
  }) {
    return ClientsBasicInfo(
      id: id, // id remains the same, as it's usually a fixed identifier
      name: name ?? this.name,
      sexo: sexo ?? this.sexo,
      frequencia: frequencia ?? this.frequencia,
      alunoCpf: alunoCpf ?? this.alunoCpf,
      vencimento: vencimento ?? this.vencimento,
      objetivo: objetivo ?? this.objetivo,
      avaliacao: avaliacao ?? this.avaliacao,
      email: email ?? this.email,
      dataNascimento: dataNascimento ?? this.dataNascimento,
      imagePath: imagePath ?? this.imagePath,
      telefone: telefone ?? this.telefone,
    );
  }

  @override
  String toString() {
    return 'ClientsBasicInfo(name: $name, imagePath: $imagePath, dataNascimento: $dataNascimento, frequencia: $frequencia)';
  }
}
