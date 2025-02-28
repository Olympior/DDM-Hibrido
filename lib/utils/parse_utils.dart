class ParseUtils {
  static ({double medida, String unidade}) parseMedida(String medidaStr) {
    const unidadesValidas = ['g', 'kg', 'ml', 'l'];

    for (final unidade in unidadesValidas) {
      if (medidaStr.toLowerCase().contains(unidade)) {
        final medida = medidaStr
            .replaceAll(RegExp(unidade, caseSensitive: false), '')
            .replaceAll(',', '.')
            .trim();

        final parsed = double.tryParse(medida);
        if (parsed != null && parsed > 0) {
          return (medida: parsed, unidade: unidade);
        }
      }
    }
    throw FormatException('Formato de medida inválido. Ex: 500g, 1kg, 2l');
  }

  static double parsePreco(String precoStr) {
    final cleaned = precoStr.replaceAll(',', '.').replaceAll(RegExp(r'[^0-9.]'), '');
    final parsed = double.tryParse(cleaned);
    if (parsed == null || parsed <= 0) {
      throw FormatException('Preço inválido. Use números positivos');
    }
    return parsed;
  }
}