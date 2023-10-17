import 'dart:io';

import 'package:flutter/material.dart';

class GroupWidget extends StatefulWidget {
  final String text;
  final List<Widget> children;
  final bool expandable;

  /// Height of the widget in pixels.
  final double _widgetHeight = 100;

  /// Width of the widget in pixels. Changes depending on the platform.
  late final double _widgetWidth;

  GroupWidget(
      {Key? key,
      required this.text,
      required this.children,
      this.expandable = false})
      : super(key: key) {
    _setWidgetWidhtForPlatform();
  }

  GroupWidget.expandable({
    Key? key,
    required this.text,
    required this.children,
  })  : expandable = true,
        super(key: key) {
    _setWidgetWidhtForPlatform();
  }

  void _setWidgetWidhtForPlatform() {
    if (Platform.isAndroid || Platform.isIOS) {
      _widgetWidth = 200;
    } else {
      _widgetWidth = 300;
    }
  }

  @override
  State<GroupWidget> createState() => _GroupWidgetState();

  bool get _isTextEmpty => text == "";
}

class _GroupWidgetState extends State<GroupWidget> {
  bool expanded = true;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    const widgetPadding = 10.0;
    int crossAxisCount =
        (width ~/ (widget._widgetWidth)) < 1 ? 1 : width ~/ widget._widgetWidth;

    return Column(mainAxisSize: MainAxisSize.min, children: [
      if (widget._isTextEmpty)
        const SizedBox(
          height: 25,
        ),
      if (!widget._isTextEmpty)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: SizedBox(
            height: 50,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.text,
                    style: Theme.of(context).textTheme.headlineSmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (widget.expandable)
                  IconButton(
                    onPressed: () {
                      setState(() {
                        expanded = !expanded;
                      });
                    },
                    icon: Icon(
                      expanded ? Icons.expand_less : Icons.expand_more,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
              ],
            ),
          ),
        ),
      if (expanded)
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (int i = 0; i < widget.children.length / crossAxisCount; i++)
              Row(
                children: [
                  for (int j = 0;
                      j < crossAxisCount &&
                          (i * crossAxisCount + j) < widget.children.length;
                      j++)
                    Padding(
                      padding: const EdgeInsets.all(widgetPadding),
                      child: SizedBox(
                        width: widget._widgetWidth - 2 * widgetPadding,
                        height: widget._widgetHeight,
                        child: widget.children[i * crossAxisCount + j],
                      ),
                    )
                ],
              )
          ],
        ),
    ]);
  }
}
