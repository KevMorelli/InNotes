import 'package:flutter/material.dart';
import 'package:in_notes/core/view_models/prototype_view_model.dart';
import 'package:stacked/stacked.dart';

class PrototypeView extends StatefulWidget {
  PrototypeView({Key key}) : super(key: key);

  @override
  _PrototypeViewState createState() => _PrototypeViewState();
}

class _PrototypeViewState extends State<PrototypeView> {
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    //! zero-width space below to detect the backspace with empty text, https://github.com/flutter/flutter/issues/14809
    _controller.text = '​';
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void processText(PrototypeViewModel viewModel) {
    var processedValue = viewModel.processTextChanged(_controller.text);
    if (processedValue != _controller.text) {
      _controller.text = processedValue;
      //! zero-width space below to detect the backspace with empty text, https://github.com/flutter/flutter/issues/14809
      if (processedValue == '​') _controller.selection = TextSelection.collapsed(offset: _controller.text.length);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PrototypeViewModel>.reactive(
      viewModelBuilder: () => PrototypeViewModel(),
      builder: (context, viewModel, child) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Visibility(
                    visible: viewModel.isCheckboxVisible,
                    child: Checkbox(
                      value: viewModel.isChecked,
                      onChanged: (value) => viewModel.toggleCheckbox(value),
                    ),
                  ),
                  Expanded(
                      child: TextField(
                    style: TextStyle(
                      decoration: viewModel.isChecked ? TextDecoration.lineThrough : TextDecoration.none,
                      color: viewModel.isChecked ? Colors.grey : Colors.black,
                    ),
                    controller: _controller,
                    onChanged: (_) => processText(viewModel),
                  )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
