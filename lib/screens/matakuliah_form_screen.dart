import 'package:flutter/material.dart';
import 'package:uts_mobile/helper/database_helper.dart';
import 'package:uts_mobile/models/matakuliah.dart';

class MatakuliahFormScreen extends StatefulWidget {
  final Matakuliah? matakuliah;

  const MatakuliahFormScreen({super.key, this.matakuliah});

  @override
  State<MatakuliahFormScreen> createState() => _MatakuliahFormScreenState();
}

class _MatakuliahFormScreenState extends State<MatakuliahFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _kodeCtrl;
  late TextEditingController _namaCtrl;
  late TextEditingController _sksCtrl;
  late TextEditingController _jenisCtrl;

  bool get isEditing => widget.matakuliah != null;

  @override
  void initState() {
    super.initState();
    _kodeCtrl = TextEditingController(
      text: widget.matakuliah?.kodeMatakuliah ?? '',
    );
    _namaCtrl = TextEditingController(
      text: widget.matakuliah?.namaMatakuliah ?? '',
    );
    _sksCtrl = TextEditingController(text: widget.matakuliah?.sks ?? '');
    _jenisCtrl = TextEditingController(
      text: widget.matakuliah?.jenisMatakuliah ?? '',
    );
  }

  @override
  void dispose() {
    _kodeCtrl.dispose();
    _namaCtrl.dispose();
    _sksCtrl.dispose();
    _jenisCtrl.dispose();
    super.dispose();
  }

  Future<void> _saveMatakuliah() async {
    if (_formKey.currentState!.validate()) {
      final matakuliah = Matakuliah(
        id: widget.matakuliah?.id,
        kodeMatakuliah: _kodeCtrl.text,
        namaMatakuliah: _namaCtrl.text,
        sks: _sksCtrl.text,
        jenisMatakuliah: _jenisCtrl.text,
        createdAt: DateTime.now().toIso8601String(),
      );

      if (isEditing) {
        await DatabaseHelper.instance.update(matakuliah);
      } else {
        await DatabaseHelper.instance.insert(matakuliah);
      }

      if (!mounted) return;
      Navigator.pop(context);
    }
  }

  String? _required(String? value) {
    return value == null || value.isEmpty ? 'Data tidak boleh kosong' : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Matakuliah' : 'Tambah Matakuliah'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _kodeCtrl,
                decoration: const InputDecoration(labelText: 'Kode Matakuliah'),
                validator: _required,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _namaCtrl,
                decoration: const InputDecoration(labelText: 'Nama Matakuliah'),
                validator: _required,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _sksCtrl,
                decoration: const InputDecoration(labelText: 'SKS'),
                keyboardType: TextInputType.number,
                validator: _required,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _jenisCtrl,
                decoration: const InputDecoration(
                  labelText: 'Jenis Matakuliah',
                ),
                validator: _required,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveMatakuliah,
                child: Text(isEditing ? 'Update' : 'Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
