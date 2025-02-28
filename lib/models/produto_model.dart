class Produto {
  final int? id;
  final String nome;
  final double preco;
  final double medida;
  final String unidade;
  final List<PrecoHistorico> historico;

  Produto({
    this.id,
    required this.nome,
    required this.preco,
    required this.medida,
    required this.unidade,
    this.historico = const [],
  });

  double get precoPorUnidade {
    switch (unidade) {
      case 'kg':
        return preco / (medida * 1000);
      case 'l':
        return preco / (medida * 1000);
      default:
        return preco / medida;
    }
  }

  String get unidadeBase {
    return unidade == 'kg' ? 'g' : unidade == 'l' ? 'ml' : unidade;
  }
}

class PrecoHistorico {
  final double preco;
  final DateTime data;

  PrecoHistorico({
    required this.preco,
    required this.data,
  });
}