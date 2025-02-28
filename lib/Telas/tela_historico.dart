import 'package:flutter/material.dart';
import '../models/produto_model.dart';
import '../database/database_helper.dart';

class TelaHistorico extends StatelessWidget {
  const TelaHistorico({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Histórico de Preços')),
      body: FutureBuilder<List<Produto>>(
        future: DatabaseHelper.instance.getProdutos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhum histórico disponível'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final produto = snapshot.data![index];
              return _buildProdutoCard(produto);
            },
          );
        },
      ),
    );
  }

  Widget _buildProdutoCard(Produto produto) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(produto.nome, style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            )),
            const SizedBox(height: 8),
            Text('${produto.medida}${produto.unidade}'),
            const Divider(),
            Text('Histórico de Preços:', style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            )),
            ...produto.historico.map((preco) => ListTile(
              title: Text('R\$${preco.preco.toStringAsFixed(2)}'),
              subtitle: Text('${preco.data.day}/${preco.data.month}/${preco.data.year}'),
              trailing: Icon(Icons.show_chart, color: Colors.green[700]),
            )).toList(),
          ],
        ),
      ),
    );
  }
}