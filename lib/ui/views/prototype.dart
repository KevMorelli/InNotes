import 'package:flutter/material.dart';
import 'package:in_notes/core/view_models/prototype_view_model.dart';
import 'package:in_notes/ui/components/text_entry.dart';
import 'package:stacked/stacked.dart';

class PrototypeView extends StatefulWidget {
  PrototypeView({Key key}) : super(key: key);

  @override
  _PrototypeViewState createState() => _PrototypeViewState();
}

class _PrototypeViewState extends State<PrototypeView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PrototypeViewModel>.reactive(
      viewModelBuilder: () => PrototypeViewModel(),
      builder: (context, viewModel, child) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListView.builder(
              itemCount: viewModel.lines.length,
              itemBuilder: (BuildContext context, int index) {
                // access element from list using index
                // you can create and return a widget of your choice
                return TextEntry(
                  onNewLine: viewModel.onNewline,
                  isCheckboxVisible: viewModel.lines[index].isCheckboxVisible,
                  index: index,
                  onDeleteLine: viewModel.onRemoveLine,
                  isFocusing: index == viewModel.lines.length - 1,
                );
              }),
        ),
      ),
    );
  }
}
