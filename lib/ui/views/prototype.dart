import 'package:flutter/material.dart';
import 'package:in_notes/core/view_models/prototype_view_model.dart';
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
        body: Center(
          child: Text('Hello World'),
        ),
      ),
    );
  }
}
