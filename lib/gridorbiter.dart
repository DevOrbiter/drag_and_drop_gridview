import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:drag_and_drop_gridview/drag.dart';

class MainGridView extends StatefulWidget {


  MainGridView(
      {this.key,
      this.header,
      this.reverse,
      @required this.itemBuilder,
      @required this.onWillAccept,
      this.feedback,
      @required this.onReorder,
      this.childWhenDragging,
      this.controller,
      this.isCustomDragItem,
      this.isVertical = true,
      this.padding,
      this.semanticChildCount,
      this.physics,
      this.addAutomaticKeepAlives,
      this.addRepaintBoundaries,
      this.addSemanticIndexes,
      this.cacheExtent,
      this.itemCount,
      this.primary,
      this.isCustomFeedback,
      this.isCustomChildWhenDragging,
      @required this.gridDelegate,
      this.dragStartBehavior = DragStartBehavior.start,
      this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual});

     final Key key;

  final bool reverse;
  final Widget header;
  final ScrollController controller;
  final bool primary;
  final ScrollPhysics physics;

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
  final bool isCustomDragItem;
  final bool isVertical;

  // set you feedback child here and to get this working please set isCustomFeedback to true
  final Function feedback;

  // set you custom child here and to get this working please set isCustomChildWhenDragging to true
  final Function childWhenDragging;


  @override
  _MainGridViewState createState() => _MainGridViewState();
}

class _MainGridViewState extends State<MainGridView> {
  ScrollController _scrollController;
  ScrollController _scrollController2;
  var _gridViewHeight;
  var _isDragStart = false;

  @override
  void initState() {
    if (widget.controller == null) {
      _scrollController = ScrollController();
      _scrollController2 = ScrollController();
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

  Widget _headerChild() {
    return ListView(
      controller: _scrollController,
      children: [widget.header, _dragAndDropGrid()],
    );
  }

  Widget _dragAndDropGrid() {
    return GridView.builder(
      key: widget.key,
      reverse: widget.reverse,
      shrinkWrap: true,
      controller:
          widget.header == null ? _scrollController : _scrollController2,
      padding: widget.padding,
      scrollDirection: widget.isVertical ? Axis.vertical :  Axis.horizontal,
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
        var mainWidget;
        if (widget.isCustomDragItem) {
          mainWidget = widget.itemBuilder(context, pos) as DragItem;
          if (mainWidget.isDraggable) {
            return mainWidget;
          }
          print("${mainWidget.key} *************");
        } else {
          mainWidget = widget.itemBuilder(context, pos);
          print("${mainWidget.key} *************");
        }

        return DragTarget(
          builder: (context, List<int> candidateData, rejectedData) =>
              LongPressDraggable(
            data: pos,
            child: mainWidget,
            feedback:
                widget.isCustomFeedback ? widget.feedback(pos) : mainWidget,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        LayoutBuilder(builder: (context, constraints) {
          _gridViewHeight = constraints.maxHeight;
          print("$_gridViewHeight +  hhhhhhh");
          return widget.header == null ? _dragAndDropGrid() : _headerChild();
        }),
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
                    print("helo down");
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
                    print("helo down");
                    _moveDown();
                    return false;
                  },
                ),
              ),
      ],
    );
  }
}