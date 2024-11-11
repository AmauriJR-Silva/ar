import 'package:cards/model/bd.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Cartoes extends StatefulWidget {
  const Cartoes({super.key});

  @override
  State<Cartoes> createState() => _CartoesState();
}

class _CartoesState extends State<Cartoes> {
  List<Map<String, dynamic>> contato = [];

  @override
  void initState() {
    super.initState();
    _loadContato();
  }

  Future<void> _loadContato() async {
    final contatoList = await Bd.instance.getContato();
    setState(() {
      contato = contatoList;
    });
  }

  Future<void> _addContato(String nome, String numero) async {
    await Bd.instance.criarContato(nome, numero);
    _loadContato();
  }

  Future<void> _updateContato(int id, String nome, String numero) async {
    await Bd.instance.updateContato(id, nome, numero);
    _loadContato();
  }

  Future<void> _deleteContato(int id) async {
    await Bd.instance.deleteContato(id);
    _loadContato();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Text('Lista de Contatos'),
      ),
      body: ListView.builder(
        itemCount: contato.length,
        itemBuilder: (context, index) {
          final item = contato[index];
          return ListTile(
            title: Text(item['nome']),
            subtitle: Text(item['numero']),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [

                IconButton(
                  icon: Icon(Icons.edit, color: Colors.green),
                  onPressed: () {
                    _editarContato(context, item['id'], item['nome'], item['numero']);
                  },
                ),

                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    _deleteContato(item['id']);
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add_circle),
        onPressed: () {
          _adicionarContato(context);
        },
      ),
    );
  }

  void _adicionarContato(BuildContext context) {
    String nome = '';
    String numero = '';

    Alert(
      context: context,
      title: "Adicionar novo contato",
      content: Column(
        children: [
          TextField(
            decoration: const InputDecoration(
              labelText: 'Nome do Contato',
            ),
            onChanged: (value) {
              nome = value;
            },
          ),
          TextField(
            decoration: const InputDecoration(
              labelText: 'Número do Contato',
            ),
            onChanged: (value) {
              numero = value;
            },
          ),
        ],
      ),
      buttons: [
        DialogButton(
          child: const Text(
            "Adicionar",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            if (nome.isNotEmpty && numero.isNotEmpty) {
              _addContato(nome, numero);
              Navigator.of(context).pop();
            }
          },
          color: Colors.green,
        ),
        DialogButton(
          child: const Text(
            "Cancelar",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.of(context).pop(),
          color: Colors.red,
        ),
      ],
    ).show();
  }

  void _editarContato(BuildContext context, int id, String nome, String numero) {
    String novoNome = nome;
    String novoNumero = numero;

    Alert(
      context: context,
      title: "Editar contato",
      content: Column(
        children: [
          TextField(
            decoration: const InputDecoration(
              labelText: 'Nome do Contato',
            ),

            controller: TextEditingController(text: nome),
            onChanged: (value) {
              novoNome = value;
            },

          ),
          
          TextField(
            decoration: const InputDecoration(
              labelText: 'Número do Contato',
            ),
            controller: TextEditingController(text: numero),
            onChanged: (value) {
              novoNumero = value;
            },

          ),
        ],
      ),

      buttons: [
        DialogButton(
          child: const Text(
            "Salvar",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            if (novoNome.isNotEmpty && novoNumero.isNotEmpty) {
              _updateContato(id, novoNome, novoNumero);
              Navigator.of(context).pop();
            }
          },
          color: Colors.green,
        ),

        DialogButton(
          child: const Text(
            "Cancelar",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.of(context).pop(),
          color: Colors.red,
        ),
      ],
    ).show();
  }
}
