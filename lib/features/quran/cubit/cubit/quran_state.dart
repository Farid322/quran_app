import 'package:meta/meta.dart';
import 'package:quran_app/features/quran/models/sour_model.dart';

@immutable
abstract class QuranState {}

class QuranInitial extends QuranState {}

class QuranLoading extends QuranState {}

class QuranLoaded extends QuranState {
  final List<AyatSour> sourList;

  QuranLoaded(this.sourList);
}

class QuranNoResults extends QuranState {}
