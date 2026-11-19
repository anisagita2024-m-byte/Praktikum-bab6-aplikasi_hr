
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/karyawan.dart';
import 'gaji_api.dart';

// Provider untuk API
final gajiApiProvider = Provider<GajiApi>((ref) => GajiApi());

// (a) FutureProvider untuk mengambil daftar gaji
final daftarGajiProvider = FutureProvider<List<Karyawan>>(
  (ref) => ref.watch(gajiApiProvider).fetchDaftarGaji(),
);

// (d) Family untuk mengambil detail berdasarkan NIK
final gajiDetailProvider = FutureProvider.family<Karyawan, String>(
  (ref, nik) => ref.watch(gajiApiProvider).fetchDetail(nik),
);

// (b) State penggajian
class PenggajianState {
  final List<String> diproses;
  final bool isProcessing;

  const PenggajianState({
    this.diproses = const [],
    this.isProcessing = false,
  });

  int get totalDiproses => diproses.length;

  PenggajianState copyWith({
    List<String>? diproses,
    bool? isProcessing,
  }) {
    return PenggajianState(
      diproses: diproses ?? this.diproses,
      isProcessing: isProcessing ?? this.isProcessing,
    );
  }
}

// Notifier untuk mengelola proses penggajian
class PenggajianNotifier extends Notifier<PenggajianState> {
  @override
  PenggajianState build() => const PenggajianState();

  Future<void> prosesSemua(List<Karyawan> daftar) async {
    state = state.copyWith(isProcessing: true);

    await Future.delayed(const Duration(seconds: 1));

    if (!ref.mounted) return;

    state = PenggajianState(
      diproses: [for (final k in daftar) k.nik],
      isProcessing: false,
    );
  }

  void reset() {
    state = const PenggajianState();
  }
}

// Provider untuk Notifier penggajian
final penggajianProvider =
    NotifierProvider<PenggajianNotifier, PenggajianState>(
  PenggajianNotifier.new,
);
