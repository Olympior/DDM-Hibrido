import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import '../models/produto_model.dart';

class DatabaseHelper {
  static const _databaseName = "ComparadorDB.db";
  static const _databaseVersion = 1;

  static const tableProdutos = 'produtos';
  static const tablePrecos = 'precos';

  static const columnId = 'id';
  static const columnNome = 'nome';
  static const columnMedida = 'medida';
  static const columnUnidade = 'unidade';
  static const columnPreco = 'preco';
  static const columnData = 'data';
  static const columnProdutoId = 'produto_id';

  static Database? _database;

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _databaseName);

    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableProdutos (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnNome TEXT NOT NULL,
        $columnMedida REAL NOT NULL,
        $columnUnidade TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE $tablePrecos (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnPreco REAL NOT NULL,
        $columnData TEXT NOT NULL,
        $columnProdutoId INTEGER NOT NULL,
        FOREIGN KEY ($columnProdutoId) REFERENCES $tableProdutos ($columnId)
      )
    ''');
  }

  Future<int> insertProduto(Produto produto) async {
    final db = await database;
    return await db.insert(tableProdutos, {
      columnNome: produto.nome,
      columnMedida: produto.medida,
      columnUnidade: produto.unidade,
    });
  }

  Future<List<Produto>> getProdutos() async {
    final db = await database;
    final List<Map<String, dynamic>> produtosMap = await db.query(tableProdutos);

    return await Future.wait(produtosMap.map((map) async {
      final historico = await getHistorico(map[columnId]);
      return Produto(
        id: map[columnId],
        nome: map[columnNome],
        preco: 0,
        medida: map[columnMedida],
        unidade: map[columnUnidade],
        historico: historico,
      );
    }));
  }

  Future<int> insertPreco(int produtoId, double preco) async {
    final db = await database;
    return await db.insert(tablePrecos, {
      columnPreco: preco,
      columnData: DateTime.now().toIso8601String(),
      columnProdutoId: produtoId,
    });
  }

  Future<List<PrecoHistorico>> getHistorico(int produtoId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      tablePrecos,
      where: '$columnProdutoId = ?',
      whereArgs: [produtoId],
    );

    return maps.map((map) => PrecoHistorico(
      preco: map[columnPreco],
      data: DateTime.parse(map[columnData]),
    )).toList();
  }
}