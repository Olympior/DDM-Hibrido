import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'tela_comparacao.dart';
import 'tela_historico.dart';
import 'tela_escaneamento.dart';
import '../models/produto_model.dart';
import '../utils/parse_utils.dart';

class TelaComparador extends StatefulWidget {
  const TelaComparador({super.key});

  @override
  State<TelaComparador> createState() => _TelaComparadorState();
}

class _TelaComparadorState extends State<TelaComparador> {
  final List<TextEditingController> _nomeControllers = List.generate(3, (_) => TextEditingController());
  final List<TextEditingController> _medidaControllers = List.generate(3, (_) => TextEditingController());
  final List<TextEditingController> _precoControllers = List.generate(3, (_) => TextEditingController());

  Widget _buildCamposProduto(int index) {
    return Column(
      children: [
        TextField(
          controller: _nomeControllers[index],
          decoration: InputDecoration(
            labelText: 'Produto ${index + 1}',
            suffixIcon: IconButton(
              icon: const Icon(Icons.qr_code_scanner),
              onPressed: () => _abrirScanner(context, index),
            ),
          ),
        ),
        TextField(
          controller: _medidaControllers[index],
          decoration: const InputDecoration(
            labelText: 'Medida (ex: 200g, 1L)',
          ),
        ),
        TextField(
          controller: _precoControllers[index],
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Preço Total',
            prefixText: 'R\$ ',
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  void _abrirScanner(BuildContext context, int index) async {
    final productData = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(builder: (context) => const TelaEscaneamento()),
    );

    if (productData != null && mounted) {
      _preencherCampos(
        index,
        productData['nome'],
        productData['quantidade'],
      );
    }
  }

  void _preencherCampos(int index, String nome, String medida) {
    setState(() {
      _nomeControllers[index].text = nome;
      _medidaControllers[index].text = medida;
      _precoControllers[index].text = ''; // Sempre limpa o preço
    });
  }

  void _comparar() {
    try {
      final produtos = <Produto>[];

      for (int i = 0; i < 3; i++) {
        if (_camposPreenchidos(i)) {
          produtos.add(_criarProduto(i));
        }
      }

      if (produtos.length < 2) {
        throw Exception('Preencha pelo menos 2 produtos');
      }

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TelaComparacao(produtos: produtos),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString()))
      );
    }
  }

  bool _camposPreenchidos(int index) {
    return _nomeControllers[index].text.isNotEmpty &&
        _medidaControllers[index].text.isNotEmpty &&
        _precoControllers[index].text.isNotEmpty;
  }

  Produto _criarProduto(int index) {
    final medidaData = ParseUtils.parseMedida(_medidaControllers[index].text);
    return Produto(
      nome: _nomeControllers[index].text,
      preco: double.parse(_precoControllers[index].text),
      medida: medidaData.medida,
      unidade: medidaData.unidade,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comparador de Preços'),
        backgroundColor: const Color(0xFF2D802F),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            for (int i = 0; i < 3; i++) _buildCamposProduto(i),
            ElevatedButton(
              onPressed: _comparar,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2D802F),
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Comparar Preços'),
            ),
          ],
        ),
      ),
      floatingActionButton: SpeedDial(
        icon: Icons.menu,
        activeIcon: Icons.close,
        backgroundColor: const Color(0xFF2D802F),
        children: [
          SpeedDialChild(
            child: const Icon(Icons.history),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const TelaHistorico()),
            ),
          ),
        ],
      ),
    );
  }
}