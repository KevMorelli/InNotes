import 'package:in_notes/core/view_models/base_view_model.dart';

class PrototypeViewModel extends BaseViewModel {
  bool isChecked = false;
  bool isCheckboxVisible = false;

  void toggleCheckbox(bool value) {
    isChecked = value;
    notifyListeners();
  }

  String processTextChanged(String value) {
    if (value.startsWith("​[]") && !isCheckboxVisible) {
      isCheckboxVisible = true;
      notifyListeners();

      //! zero-width space below to detect the backspace with empty text, https://github.com/flutter/flutter/issues/14809
      return value.replaceRange(0, 3, '​');
    } else if (value.length == 0) {
      isCheckboxVisible = false;
      isChecked = false;
      notifyListeners();

      //! zero-width space below to detect the backspace with empty text, https://github.com/flutter/flutter/issues/14809
      return '​';
    }

    return value;
  }
}
