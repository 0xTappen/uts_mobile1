import 'package:flutter/material.dart';
import 'package:uts_mobile/helper/database_helper.dart';
import 'package:uts_mobile/models/matakuliah.dart';

class MatakuliahListScreen extends StatefulWidget {
  const MatakuliahListScreen({super.key});

  @override
  State<MatakuliahListScreen> createState() => _MatakuliahListScreenState();
}

class _MatakuliahListScreenState extends State<MatakuliahListScreen> {
  List<Matakuliah> _matakuliah = [];

  @override
  void initState() {
    super.initState();
    _refreshMatakuliah();
  }

  Future<void> _refreshMatakuliah() async {
    final matakuliah = await DatabaseHelper.instance.getAll();
    setState(() {
      _matakuliah = matakuliah;
    });
  }

  Future<void> _deleteMatakuliah(int id) async {
    await DatabaseHelper.instance.delete(id);
    _refreshMatakuliah();
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Matakuliah berhasil dihapus')),
    );
  }

  @override
  Widget build(BuildContext context) {
    const red = Color(0xFFC62828);
    const yellow = Color(0xFFFFD54F);
    const blue = Color(0xFF1565C0);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: blue,
        foregroundColor: Colors.white,
        title: const Text('Data Matakuliah'),
      ),
      body: Column(
        children: [
          Container(
            height: 10,
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [red, yellow, blue]),
            ),
          ),
          Expanded(
            child: _matakuliah.isEmpty
                ? const Center(child: Text('Belum ada data matakuliah'))
                : ListView.builder(
                    itemCount: _matakuliah.length,
                    itemBuilder: (context, index) {
                      final matakuliah = _matakuliah[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: yellow,
                          foregroundColor: Colors.black,
                          child: Text(matakuliah.sks),
                        ),
                        title: Text(matakuliah.namaMatakuliah),
                        subtitle: Text(
                          '${matakuliah.kodeMatakuliah} | '
                          '${matakuliah.jenisMatakuliah}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: red),
                          onPressed: () => _deleteMatakuliah(matakuliah.id!),
                        ),
                        onTap: () async {
                          await Navigator.pushNamed(
                            context,
                            '/form',
                            arguments: matakuliah,
                          );
                          _refreshMatakuliah();
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: red,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.pushNamed(context, '/form');
          _refreshMatakuliah();
        },
      ),
    );
  }
}
