class Cidade {
  final String cidade;
  final String cep;
  final String uf;
  final String ddd;

  Cidade(this.cidade, this.uf, this.cep, this.ddd);

  factory Cidade.fromJson(Map<String, dynamic> json) {
    return Cidade(
      json["localidade"],
      json["uf"],
      json["cep"],
      json["ddd"],
    );
  }
}
