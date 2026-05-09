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
    const darkText = Color(0xFF162033);

    return Scaffold(
      appBar: AppBar(title: const Text('Data Matakuliah')),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 22),
            decoration: const BoxDecoration(
              color: blue,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 92,
                  height: 7,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(99),
                    gradient: const LinearGradient(
                      colors: [red, yellow, Colors.white],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Kelola Data Kuliah',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '${_matakuliah.length} matakuliah tersimpan',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.82),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: _matakuliah.isEmpty
                ? const _EmptyMatakuliah()
                : ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: _matakuliah.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final matakuliah = _matakuliah[index];
                      return Card(
                        child: InkWell(
                          borderRadius: BorderRadius.circular(14),
                          onTap: () async {
                            await Navigator.pushNamed(
                              context,
                              '/form',
                              arguments: matakuliah,
                            );
                            _refreshMatakuliah();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(14),
                            child: Row(
                              children: [
                                Container(
                                  width: 54,
                                  height: 54,
                                  decoration: BoxDecoration(
                                    color: yellow,
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        matakuliah.sks,
                                        style: const TextStyle(
                                          color: darkText,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      const Text(
                                        'SKS',
                                        style: TextStyle(
                                          color: darkText,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        matakuliah.namaMatakuliah,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          color: darkText,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Wrap(
                                        spacing: 8,
                                        runSpacing: 6,
                                        children: [
                                          _InfoChip(
                                            icon: Icons.tag,
                                            label: matakuliah.kodeMatakuliah,
                                            color: blue,
                                          ),
                                          _InfoChip(
                                            icon: Icons.category,
                                            label: matakuliah.jenisMatakuliah,
                                            color: red,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete_outline),
                                  color: red,
                                  tooltip: 'Hapus',
                                  onPressed: () =>
                                      _deleteMatakuliah(matakuliah.id!),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.pushNamed(context, '/form');
          _refreshMatakuliah();
        },
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({
    required this.icon,
    required this.label,
    required this.color,
  });

  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.09),
        borderRadius: BorderRadius.circular(99),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyMatakuliah extends StatelessWidget {
  const _EmptyMatakuliah();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 74,
              height: 74,
              decoration: BoxDecoration(
                color: const Color(0xFFFFD54F),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.menu_book,
                color: Color(0xFF1565C0),
                size: 34,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Belum ada data matakuliah',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 6),
            Text(
              'Tekan tombol tambah untuk mengisi data pertama.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black.withValues(alpha: 0.58)),
            ),
          ],
        ),
      ),
    );
  }
}
