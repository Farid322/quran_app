import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/features/quran/cubit/cubit/quran_state.dart';
import 'package:quran_app/features/quran/models/sour_model.dart';

class QuranCubit extends Cubit<QuranState> {
  QuranCubit() : super(QuranInitial());

  final List<AyatSour> _originalSour = sour;

  void loadSour() {
    emit(QuranLoading());
    Future.delayed(Duration(seconds: 1), () {
      emit(QuranLoaded(_originalSour));
    });
  }

  void searchSour(String query) {
    if (query.isEmpty) {
      emit(QuranLoaded(_originalSour));
    } else {
      final filteredSour = _originalSour
          .where((sura) => sura.name.contains(query))
          .toList();
      if (filteredSour.isEmpty) {
        emit(QuranNoResults());
      } else {
        emit(QuranLoaded(filteredSour));
      }
    }
  }
}
