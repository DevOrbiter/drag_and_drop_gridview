import 'package:drag_and_drop_gridview/drag.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

typedef bool WillAcceptCallback(int data, int position);
typedef Widget WidgetPositionBuilder(int index);

class MainGridView extends StatefulWidget {
  MainGridView(
      {this.key,
      this.header,
      this.headerItemCount,
      this.reverse,
      this.headerGridDelegate,
      @required this.itemBuilder,
      @required this.onWillAccept,
      this.feedback,
      @required this.onReorder,
      this.childWhenDragging,
      this.itemBuilderHeader,
      this.controller,
      this.isVertical = true,
      this.padding,
      this.semanticChildCount,
      this.physics,
      this.addAutomaticKeepAlives,
      this.addRepaintBoundaries,
      this.addSemanticIndexes,
      this.headerPadding,
      this.cacheExtent,
      this.itemCount,
      this.allHeaderChildNonDraggable = false,
      this.primary,
      this.isStickyHeader = false,
      this.onReorderHeader,
      this.onWillAcceptHeader,
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
  final WillAcceptCallback onWillAccept;
  final WillAcceptCallback onWillAcceptHeader;
  final bool allHeaderChildNonDraggable;
  final EdgeInsetsGeometry headerPadding;

  // This method onReorder has two parameters oldIndex and newIndex
  final ReorderCallback onReorder;
  final ReorderCallback onReorderHeader;

  final EdgeInsetsGeometry padding;
  final int headerItemCount;
  final bool isStickyHeader;
  final SliverGridDelegate headerGridDelegate;
  final SliverGridDelegate gridDelegate;
  final IndexedWidgetBuilder itemBuilder;
  final IndexedWidgetBuilder itemBuilderHeader;
  final int itemCount;
  final bool addAutomaticKeepAlives;
  final bool addRepaintBoundaries;
  final bool addSemanticIndexes;
  final double cacheExtent;
  final int semanticChildCount;
  final DragStartBehavior dragStartBehavior;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;
  final bool isVertical;

  /// set your feedback child here and to get this working please set isCustomFeedback to true
  final WidgetPositionBuilder feedback;

  /// set your custom child here and to get this working please set isCustomChildWhenDragging to true
  final WidgetPositionBuilder childWhenDragging;

  @override
  _MainGridViewState createState() => _MainGridViewState();
}

class _MainGridViewState extends State<MainGridView> {
  ScrollController _scrollController;
  ScrollController _scrollController2;
  var _gridViewHeight, _gridViewWidth;
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

  _moveLeft() {
    _scrollController.animateTo(_scrollController.offset - _gridViewWidth,
        curve: Curves.linear, duration: Duration(milliseconds: 500));
  }

  _moveRight() {
    _scrollController.animateTo(_scrollController.offset + _gridViewWidth,
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
      scrollDirection: widget.isVertical ? Axis.vertical : Axis.horizontal,
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
        var mainWidget = widget.itemBuilder(context, pos);
        if (mainWidget is DragItem) {
          if (!mainWidget.isDraggable) {
            if (!mainWidget.isDropable) {
              return mainWidget;
            }
            return _gridChild(mainWidget, pos, isNonDraggable: true);
          }
        }

        return _gridChild(mainWidget, pos);
      },
      gridDelegate: widget.gridDelegate,
    );
  }

  Widget _gridChild(Widget mainWidget, int pos,
      {bool isFromArrangeP = false, bool isNonDraggable = false}) {
    return DragTarget(
      builder: (context, List<String> candidateData, rejectedData) =>
          isNonDraggable
              ? mainWidget
              : _dragItemBuilder(mainWidget, pos,
                  isFromArrange: isFromArrangeP),
      onWillAccept: (data) {
        if (!isFromArrangeP) {
          return widget.onWillAccept(int.parse(data), pos);
        }
        return data.toString().contains("h")
            ? widget.onWillAcceptHeader(
                int.parse(data.toString().replaceAll("h", "")), pos)
            : false;
      },
      onAccept: (data) {
        if (isFromArrangeP) {
          if (data.toString().contains("h")) {
            widget.onReorderHeader(
                int.parse(data.toString().replaceAll("h", "")), pos);
          }
        } else
          widget.onReorder(int.parse(data), pos);
      },
    );
  }

  Widget _dragItemBuilder(Widget mainWidget, int pos,
      {bool isFromArrange = false}) {
    return LongPressDraggable(
      data: isFromArrange ? "h$pos" : "$pos",
      child: mainWidget,
      feedback: widget.isCustomFeedback ? widget.feedback(pos) : mainWidget,
      childWhenDragging: widget.isCustomChildWhenDragging
          ? widget.childWhenDragging(pos)
          : mainWidget,
      axis: isFromArrange
          ? widget.isVertical ? Axis.horizontal : Axis.vertical
          : null,
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
    );
  }

  Widget _tableBuilderHorizontal() {
    return Row(
      children: [
        NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overscroll) {
            overscroll.disallowGlow();
            return true;
          },
          child: GridView.builder(
            shrinkWrap: true,
            padding: widget.headerPadding,
            gridDelegate: widget.headerGridDelegate ?? widget.gridDelegate,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, pos) {
              var mainWidget = widget.itemBuilderHeader(context, pos);
              if (widget.allHeaderChildNonDraggable) {
                return mainWidget;
              }
              if (mainWidget is DragItem) {
                if (!mainWidget.isDraggable) {
                  if (!mainWidget.isDropable) {
                    return mainWidget;
                  }
                  return _gridChild(mainWidget, pos,
                      isFromArrangeP: true, isNonDraggable: true);
                }
              }

              return _gridChild(mainWidget, pos, isFromArrangeP: true);
            },
            itemCount: widget.headerItemCount,
          ),
        ),
        Expanded(
          child: _dragAndDropGrid(),
        ),
      ],
    );
  }

  Widget _tableBuilder() {
    return Column(
      children: [
        NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overscroll) {
            overscroll.disallowGlow();
            return true;
          },
          child: GridView.builder(
            shrinkWrap: true,
            padding: widget.headerPadding,
            gridDelegate: widget.headerGridDelegate ?? widget.gridDelegate,
            itemBuilder: (context, pos) {
              var mainWidget = widget.itemBuilderHeader(context, pos);
              if (widget.allHeaderChildNonDraggable) {
                return mainWidget;
              }
              if (mainWidget is DragItem) {
                if (!mainWidget.isDraggable) {
                  if (!mainWidget.isDropable) {
                    return mainWidget;
                  }
                  return _gridChild(mainWidget, pos,
                      isFromArrangeP: true, isNonDraggable: true);
                }
              }

              return _gridChild(mainWidget, pos, isFromArrangeP: true);
            },
            itemCount: widget.headerItemCount,
          ),
        ),
        Expanded(
          child: _dragAndDropGrid(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        LayoutBuilder(builder: (context, constraints) {
          _gridViewHeight = constraints.maxHeight;
          _gridViewWidth = constraints.maxWidth;
          return widget.isStickyHeader
              ? widget.isVertical ? _tableBuilder() : _tableBuilderHorizontal()
              : widget.header == null ? _dragAndDropGrid() : _headerChild();
        }),
        !_isDragStart
            ? SizedBox()
            : Align(
                alignment: widget.isVertical
                    ? Alignment.topCenter
                    : Alignment.centerRight,
                child: DragTarget(
                  builder:
                      (context, List<String> candidateData, rejectedData) =>
                          Container(
                    height: widget.isVertical ? 20 : double.infinity,
                    width: widget.isVertical ? double.infinity : 20,
                    color: Colors.transparent,
                  ),
                  onWillAccept: (data) {
                    if (!widget.isVertical) {
                      _moveRight();
                      return false;
                    }
                    _moveUp();
                    return false;
                  },
                ),
              ),
        !_isDragStart
            ? SizedBox()
            : Align(
                alignment: widget.isVertical
                    ? Alignment.bottomCenter
                    : Alignment.centerLeft,
                child: DragTarget(
                  builder:
                      (context, List<String> candidateData, rejectedData) =>
                          Container(
                    height: widget.isVertical ? 20 : double.infinity,
                    width: widget.isVertical ? double.infinity : 20,
                    color: Colors.transparent,
                  ),
                  onWillAccept: (data) {
                    if (!widget.isVertical) {
                      _moveLeft();
                      return false;
                    }
                    _moveDown();
                    return false;
                  },
                ),
              ),
      ],
    );
  }
}
