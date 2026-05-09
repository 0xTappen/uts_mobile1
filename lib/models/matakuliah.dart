class Matakuliah {
  final int? id;
  final String kodeMatakuliah;
  final String namaMatakuliah;
  final String sks;
  final String jenisMatakuliah;
  final String createdAt;

  Matakuliah({
    this.id,
    required this.kodeMatakuliah,
    required this.namaMatakuliah,
    required this.sks,
    required this.jenisMatakuliah,
    required this.createdAt,
  });

  // dari database ke aplikasi (menerima data)
  factory Matakuliah.fromMap(Map<String, dynamic> map) {
    return Matakuliah(
      id: map['id'] as int?,
      kodeMatakuliah: map['kode_matakuliah'] as String,
      namaMatakuliah: map['nama_matakuliah'] as String,
      sks: map['sks'] as String,
      jenisMatakuliah: map['jenis_matakuliah'] as String,
      createdAt: map['created_at'] as String,
    );
  }

  // dari aplikasi ke database (kirim data)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'kode_matakuliah': kodeMatakuliah,
      'nama_matakuliah': namaMatakuliah,
      'sks': sks,
      'jenis_matakuliah': jenisMatakuliah,
      'created_at': createdAt,
    };
  }
}
