import 'package:flutter/material.dart';
import '../models/produto_model.dart';
import '../database/database_helper.dart';

class TelaComparacao extends StatelessWidget {
  final List<Produto> produtos;

  const TelaComparacao({super.key, required this.produtos});

  Widget _buildCardProduto(Produto produto) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(produto.nome,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(height: 10),
            Text('${produto.medida}${produto.unidade} por R\$${produto.preco.toStringAsFixed(2)}'),
            Text('Preço por ${produto.unidadeBase}: R\$${produto.precoPorUnidade.toStringAsFixed(4)}',
                style: TextStyle(
                  color: Colors.green[800],
                  fontWeight: FontWeight.w500,
                )),
          ],
        ),
      ),
    );
  }

  Future<void> _salvarHistorico(BuildContext context) async {
    try {
      final db = DatabaseHelper.instance;
      for (final produto in produtos) {
        final produtoId = await db.insertProduto(produto);
        await db.insertPreco(produtoId, produto.preco);
      }
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Histórico salvo com sucesso!'))
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao salvar: ${e.toString()}'))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    produtos.sort((a, b) => a.precoPorUnidade.compareTo(b.precoPorUnidade));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Resultado da Comparação'),
        backgroundColor: const Color(0xFF2D802F),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.green[200]!),
              ),
              child: Text('Mais Econômico: ${produtos.first.nome}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[900],
                  )),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: produtos.map(_buildCardProduto).toList(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            onPressed: () => _salvarHistorico(context),
            tooltip: 'Salvar Histórico',
            backgroundColor: Colors.blue,
            child: const Icon(Icons.save, color: Colors.white),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () => Navigator.pop(context),
            backgroundColor: const Color(0xFF2D802F),
            child: const Icon(Icons.arrow_back, color: Colors.white),
          ),
        ],
      ),
    );
  }
}