import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_tts/flutter_tts.dart';

part 'text_to_speach_state.dart';

class TextToSpeachCubit extends Cubit<TextToSpeachState> {
  TextToSpeachCubit() : super(TextToSpeachInitial());
  final FlutterTts _flutterTts = FlutterTts();
  Future<void> play(String textNeededtoSpeak) async{
    _flutterTts.setSpeechRate(0.4);
    emit(TextToSpeachPlaying());
    await _flutterTts.speak(textNeededtoSpeak);
    _flutterTts.setCompletionHandler(() {
      _flutterTts.stop();
      emit(TextToSpeachInitial());
    });
  }
  Future<void> pause() async {
    await _flutterTts.pause();
    emit(TextToSpeachPaused());
  }

  Future<void> dispose() async{
    await _flutterTts.stop();
  }
}
