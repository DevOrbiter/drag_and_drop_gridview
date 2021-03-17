import 'package:flutter/material.dart';

class DragItem extends StatefulWidget {
  final Key? key;
  final bool isDraggable;
  final bool isDropable;
  final Widget child;

  DragItem({
    this.key,
    this.isDraggable = true,
    this.isDropable = true,
    /*required*/ required this.child,
  });

  @override
  _DragItemState createState() => _DragItemState();
}

class _DragItemState extends State<DragItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      key: widget.key,
      child: widget.child,
    );
  }
}
