import 'package:flutter_test/flutter_test.dart';
import 'package:uts_mobile/models/matakuliah.dart';

void main() {
  test('matakuliah converts to and from map', () {
    final matakuliah = Matakuliah(
      id: 1,
      kodeMatakuliah: 'IF101',
      namaMatakuliah: 'Mobile 1',
      sks: '3',
      jenisMatakuliah: 'Wajib',
      createdAt: '2026-05-09T15:00:00.000',
    );

    final map = matakuliah.toMap();
    final result = Matakuliah.fromMap(map);

    expect(result.id, 1);
    expect(result.kodeMatakuliah, 'IF101');
    expect(result.namaMatakuliah, 'Mobile 1');
    expect(result.sks, '3');
    expect(result.jenisMatakuliah, 'Wajib');
  });
}
