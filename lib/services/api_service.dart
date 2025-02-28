import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'https://world.openfoodfacts.org/api/v0/product/';

  static Future<Map<String, dynamic>> getProduct(String barcode) async {
    final response = await http.get(Uri.parse('$_baseUrl$barcode.json'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data['status'] == 0) {
        throw Exception('Produto não encontrado na base de dados');
      }

      return _parseProductData(data['product']);
    }
    throw Exception('Erro na conexão com a API: ${response.statusCode}');
  }

  static Map<String, dynamic> _parseProductData(Map<String, dynamic> product) {
    return {
      'nome': _getProductName(product),
      'quantidade': _getQuantity(product),
      'marca': product['brands'] ?? 'Marca não informada',
    };
  }

  static String _getProductName(Map<String, dynamic> product) {
    return product['product_name_pt'] ??
        product['product_name'] ??
        'Nome não disponível';
  }

  static String _getQuantity(Map<String, dynamic> product) {
    final quantity = product['quantity']?.toString().trim() ?? '';
    final servingSize = product['serving_size']?.toString().trim() ?? '';

    if (quantity.isNotEmpty) return quantity;
    if (servingSize.isNotEmpty) return servingSize;

    return '100g'; // Valor padrão se ambos estiverem ausentes
  }
}