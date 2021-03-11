import 'package:in_notes/core/models/editor_data_line.dart';
import 'package:in_notes/core/view_models/base_view_model.dart';

class PrototypeViewModel extends BaseViewModel {
  List<EditorDataLine> lines = [EditorDataLine()];
  int focusIndex = 0;

  void onNewline(int index, bool isCheckboxVisible) {
    lines.insert(index + 1, EditorDataLine(isCheckboxVisible: isCheckboxVisible));
    focusIndex = index + 1;

    notifyListeners();
  }

  void onRemoveLine(int index) {
    if (index <= 0) return;

    lines.removeAt(index);
    focusIndex = index - 1;

    notifyListeners();
  }

  void changeIndex(int oldValue, int newValue) {
    if (newValue > lines.length - 1) newValue = lines.length - 1;
    lines.insert(newValue, lines.removeAt(oldValue));

    notifyListeners();
  }
}
