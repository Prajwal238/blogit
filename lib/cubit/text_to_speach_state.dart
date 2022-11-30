part of 'text_to_speach_cubit.dart';

abstract class TextToSpeachState extends Equatable {
  const TextToSpeachState();

  @override
  List<Object?> get props => [];
}

class TextToSpeachInitial extends TextToSpeachState {}

class TextToSpeachPlaying extends TextToSpeachState {}

class TextToSpeachPaused extends TextToSpeachState {}
