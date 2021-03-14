import 'package:flutter/material.dart';

typedef NewLineCallback = void Function(int index, bool isCheckboxVisible);
typedef DeleteLineCallback = void Function(int index);

class TextEntry extends StatefulWidget {
  TextEntry({this.onNewLine, this.onDeleteLine, this.isCheckboxVisible, this.index, this.isFocusing, Key key}) : super(key: key);

  final NewLineCallback onNewLine;
  final DeleteLineCallback onDeleteLine;
  final bool isCheckboxVisible;
  final int index;
  final bool isFocusing;

  @override
  _TextEntryState createState() => _TextEntryState();
}

class _TextEntryState extends State<TextEntry> {
  TextEditingController _controller;
  FocusNode _focusNode;
  bool _isChecked = false;
  bool _isCheckboxVisible = false;
  bool _isDragHandleVisible = false;

  bool _isHeader = false;
  List<double> _fontSizes = [14, 32, 24, 18.72, 16, 13.28, 10.72];
  int _fontSizeIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    //! zero-width space below to detect the backspace with empty text, https://github.com/flutter/flutter/issues/14809
    _controller.text = '​';

    _isCheckboxVisible = widget.isCheckboxVisible == null ? false : widget.isCheckboxVisible;

    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();

    super.dispose();
  }

  void toggleCheckbox(bool value) {
    setState(() {
      _isChecked = value;
    });
  }

  void onNewLine() {
    if (_isCheckboxVisible && _controller.text.length <= 1) {
      setState(() {
        _isCheckboxVisible = false;
        _isChecked = false;
      });
    } else {
      widget.onNewLine(widget.index, _isCheckboxVisible && _controller.text.length > 1);
    }
  }

  void processText() {
    var processedValue = processTextChanged(_controller.text);
    if (processedValue != _controller.text) {
      _controller.text = processedValue;

      //! zero-width space below to detect the backspace with empty text, https://github.com/flutter/flutter/issues/14809
      if (processedValue == '​') _controller.selection = TextSelection.collapsed(offset: _controller.text.length);
    }
  }

  String processTextChanged(String value) {
    if (value.startsWith("​[]") && !_isCheckboxVisible) {
      setState(() {
        _isCheckboxVisible = true;
      });

      //! zero-width space below to detect the backspace with empty text, https://github.com/flutter/flutter/issues/14809
      return value.replaceRange(0, 3, '​');
    } else if (value.startsWith("​#") && !_isCheckboxVisible && (!_isHeader || _fontSizeIndex < _fontSizes.length - 1)) {
      if (!_isHeader) {
        _isHeader = true;
        setState(() {
          _fontSizeIndex = 1;
        });
      } else {
        setState(() {
          _fontSizeIndex++;
        });
      }

      //! zero-width space below to detect the backspace with empty text, https://github.com/flutter/flutter/issues/14809
      return value.replaceRange(0, 2, '​');
    } else if (value.length == 0) {
      var checkboxWasVisible = _isCheckboxVisible;

      setState(() {
        if (_fontSizeIndex > 0) _fontSizeIndex--;
        if (_fontSizeIndex == 0) _isHeader = false;
        _isCheckboxVisible = false;
        _isChecked = false;
      });

      if (!checkboxWasVisible) widget.onDeleteLine(widget.index);

      //! zero-width space below to detect the backspace with empty text, https://github.com/flutter/flutter/issues/14809
      return '​';
    }

    return value;
  }

  void dragHandleHover(bool isHover) {
    setState(() {
      _isDragHandleVisible = isHover;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isFocusing) _focusNode.requestFocus();

    return Container(
      child: Row(
        children: [
          Visibility(
            visible: _isCheckboxVisible,
            child: Checkbox(
              value: _isChecked,
              onChanged: (value) => toggleCheckbox(value),
            ),
          ),
          Expanded(
              child: TextField(
            focusNode: _focusNode,
            onSubmitted: (_) => onNewLine(),
            style: TextStyle(
              decoration: _isChecked ? TextDecoration.lineThrough : TextDecoration.none,
              color: _isChecked ? Colors.grey : Colors.black,
              fontSize: _fontSizes[_fontSizeIndex],
              fontWeight: _isHeader ? FontWeight.bold : FontWeight.normal,
            ),
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.all(8),
              hoverColor: Colors.grey.shade200,
              fillColor: Colors.transparent,
              filled: true,
              border: InputBorder.none,
            ),
            controller: _controller,
            onChanged: (_) => processText(),
          )),
          ReorderableDragStartListener(
            child: MouseRegion(
              child: Icon(
                Icons.drag_handle,
                color: _isDragHandleVisible ? Colors.black : Colors.transparent,
              ),
              onHover: (_) => dragHandleHover(true),
              onExit: (_) => dragHandleHover(false),
            ),
            index: widget.index,
          )
        ],
      ),
    );
  }
}
