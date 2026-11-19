import 'dart:math';

import '../models/karyawan.dart'; 

class GajiApi {
  final _random = Random();

  Future<List<Karyawan>> fetchDaftarGaji() async {
    await Future.delayed(const Duration(seconds: 2));

    // Simulasi error secara acak
    if (_random.nextInt(4) == 0) {
      throw Exception('Gagal terhubung ke server penggajian.');
    }

    return dummyKaryawan;
  }
  Future<Karyawan> fetchDetail(String nik) async {
    await Future.delayed(const Duration(seconds:1));
    final karyawan = cariKaryawan(nik);
    if (karyawan == null) {
      throw Exception('Karyawan dengan NIK $nik tidak ditemukan.');
    }
    return karyawan;
  }
}