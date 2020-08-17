import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class DragAndDropGridView extends StatefulWidget {
  final Key key;

  // set the scroll direction
  final Axis scrollDirection;
  final bool reverse;
  final Widget header;
  final ScrollController controller;
  final bool primary;
  final ScrollPhysics physics;
  final bool shrinkWrap;

  // If you want to set custom feedback child at the time of drag then set this parameter to true
  final bool isCustomFeedback;

  // If you want to set custom child at the time of drag then set this parameter to true
  final bool isCustomChildWhenDragging;

  // onWillAccept determine whether the drag object will accept or not. Based on that return a bool.
  final Function onWillAccept;

  // This method onReorder has two parameters oldIndex and newIndex
  final Function onReorder;

  final EdgeInsetsGeometry padding;
  final SliverGridDelegate gridDelegate;
  final IndexedWidgetBuilder itemBuilder;
  final int itemCount;
  final bool addAutomaticKeepAlives;
  final bool addRepaintBoundaries;
  final bool addSemanticIndexes;
  final double cacheExtent;
  final int semanticChildCount;
  final DragStartBehavior dragStartBehavior;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;

  // set you feedback child here and to get this working please set isCustomFeedback to true
  final Function feedback;

  // set you custom child here and to get this working please set isCustomChildWhenDragging to true
  final Function childWhenDragging;

  DragAndDropGridView(
      {this.key,
      this.header,
      this.reverse = false,
      this.shrinkWrap = false,
      @required this.itemBuilder,
      @required this.onWillAccept,
      this.feedback,
      @required this.onReorder,
      this.childWhenDragging,
      this.controller,
      this.scrollDirection = Axis.vertical,
      this.padding,
      this.semanticChildCount,
      this.physics,
      this.addAutomaticKeepAlives = false,
      this.addRepaintBoundaries = false,
      this.addSemanticIndexes = false,
      this.cacheExtent,
      this.itemCount,
      this.primary,
      this.isCustomFeedback = false,
      this.isCustomChildWhenDragging = false,
      @required this.gridDelegate,
      this.dragStartBehavior = DragStartBehavior.start,
      this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual});

  @override
  _DragAndDropGridViewState createState() => _DragAndDropGridViewState();
}

class _DragAndDropGridViewState extends State<DragAndDropGridView> {
  ScrollController _scrollController;
  var _gridViewHeight;
  var _isDragStart = false;

  @override
  void initState() {
    if (widget.controller == null) {
      _scrollController = ScrollController();
    } else
      _scrollController = widget.controller;
    super.initState();
  }

  _moveUp() {
    _scrollController.animateTo(_scrollController.offset - _gridViewHeight,
        curve: Curves.linear, duration: Duration(milliseconds: 500));
  }

  _moveDown() {
    _scrollController.animateTo(_scrollController.offset + _gridViewHeight,
        curve: Curves.linear, duration: Duration(milliseconds: 500));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          children: [
            widget.header ??
                SizedBox(
                  height: 0.2,
                ),
             GridView.builder(
                key: widget.key,
                reverse: widget.reverse,
                shrinkWrap: true,
                controller: _scrollController,
                scrollDirection: widget.scrollDirection,
                padding: widget.padding,
                semanticChildCount: widget.semanticChildCount,
                physics: widget.physics,
                addSemanticIndexes: widget.addSemanticIndexes,
                addRepaintBoundaries: widget.addRepaintBoundaries,
                addAutomaticKeepAlives: widget.addAutomaticKeepAlives,
                cacheExtent: widget.cacheExtent,
                itemCount: widget.itemCount,
                primary: widget.primary,
                dragStartBehavior: widget.dragStartBehavior,
                keyboardDismissBehavior: widget.keyboardDismissBehavior,
                itemBuilder: (context, pos) {
                  final mainWidget = widget.itemBuilder(context, pos);
                  return DragTarget(
                    builder: (context, List<int> candidateData, rejectedData) =>
                        LongPressDraggable(
                      data: pos,
                      child: mainWidget,
                      feedback: widget.isCustomFeedback
                          ? widget.feedback(pos)
                          : mainWidget,
                      childWhenDragging: widget.isCustomChildWhenDragging
                          ? widget.childWhenDragging(pos)
                          : mainWidget,
                      onDragStarted: () {
                        setState(() {
                          _isDragStart = true;
                        });
                      },
                      onDragCompleted: () {
                        setState(() {
                          _isDragStart = false;
                        });
                      },
                    ),
                    onWillAccept: (data) => widget.onWillAccept(data, pos),
                    onAccept: (data) {
                      print(data);
                      widget.onReorder(data, pos);
                    },
                  );
                },
                gridDelegate: widget.gridDelegate,
              ),
            
          ],
        ),
        !_isDragStart
            ? SizedBox()
            : Align(
                alignment: Alignment.topCenter,
                child: DragTarget(
                  builder: (context, List<int> candidateData, rejectedData) =>
                      Container(
                    height: 20,
                    color: Colors.transparent,
                  ),
                  onWillAccept: (data) {
                    _moveUp();
                    return false;
                  },
                ),
              ),
        !_isDragStart
            ? SizedBox()
            : Align(
                alignment: Alignment.bottomCenter,
                child: DragTarget(
                  builder: (context, List<int> candidateData, rejectedData) =>
                      Container(
                    height: 20,
                    color: Colors.transparent,
                  ),
                  onWillAccept: (data) {
                    _moveDown();
                    return false;
                  },
                ),
              ),
      ],
    );
  }
}
