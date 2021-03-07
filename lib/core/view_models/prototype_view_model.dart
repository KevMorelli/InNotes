import 'package:in_notes/core/models/editor_data_line.dart';
import 'package:in_notes/core/view_models/base_view_model.dart';

class PrototypeViewModel extends BaseViewModel {
  List<EditorDataLine> lines = [EditorDataLine()];

  void onNewline(bool isCheckboxVisible) {
    lines.add(EditorDataLine(isCheckboxVisible: isCheckboxVisible));
    notifyListeners();
  }

  void onRemoveLine(int index) {
    if (index <= 0) return;

    lines.removeAt(index);
    notifyListeners();
  }
}
