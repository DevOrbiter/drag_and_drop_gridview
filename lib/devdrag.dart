import 'package:drag_and_drop_gridview/drag.dart';
import 'package:drag_and_drop_gridview/gridorbiter.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class DragAndDropGridView extends MainGridView {
  DragAndDropGridView({
    Key key,
    bool reverse = false,
    Widget header,
    ScrollController controller,
    bool primary,
    ScrollPhysics physics,

    // If you want to set custom feedback child at the time of drag then set this parameter to true
    bool isCustomFeedback = false,

    // If you want to set custom child at the time of drag then set this parameter to true
    bool isCustomChildWhenDragging = false,

    // onWillAccept determine whether the drag object will accept or not. Based on that return a bool.
    @required Function onWillAccept,

    // This method onReorder has two parameters oldIndex and newIndex
    @required Function onReorder,
    EdgeInsetsGeometry padding,
    @required SliverGridDelegate gridDelegate,
    @required IndexedWidgetBuilder itemBuilder,
    int itemCount,
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    bool addSemanticIndexes = true,
    double cacheExtent,
    int semanticChildCount,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    ScrollViewKeyboardDismissBehavior keyboardDismissBehavior =
        ScrollViewKeyboardDismissBehavior.manual,
    bool isCustomDragItem = false,
    // set you feedback child here and to get this working please set isCustomFeedback to true
    Function feedback,
    // set you custom child here and to get this working please set isCustomChildWhenDragging to true
    Function childWhenDragging,
  })  : assert(itemBuilder != null &&
            gridDelegate != null &&
            onReorder != null &&
            onWillAccept != null),
        super(
          key: key,
          reverse: reverse,
          header: header,
          itemBuilder: itemBuilder,
          onWillAccept: onWillAccept,
          feedback: feedback,
          onReorder: onReorder,
          childWhenDragging: childWhenDragging,
          controller: controller,
          isCustomDragItem: isCustomDragItem,
          padding: padding,
          semanticChildCount: semanticChildCount,
          physics: physics,
          addAutomaticKeepAlives: addAutomaticKeepAlives,
          addRepaintBoundaries: addRepaintBoundaries,
          addSemanticIndexes: addSemanticIndexes,
          cacheExtent: cacheExtent,
          itemCount: itemCount,
          primary: primary,
          isCustomFeedback: isCustomFeedback,
          isCustomChildWhenDragging: isCustomChildWhenDragging,
          gridDelegate: gridDelegate,
          dragStartBehavior: dragStartBehavior,
          keyboardDismissBehavior: keyboardDismissBehavior,
        );

  DragAndDropGridView.horizontal({
    Key key,
    bool reverse = false,
    ScrollController controller,
    bool primary,
    ScrollPhysics physics,

    // If you want to set custom feedback child at the time of drag then set this parameter to true
    bool isCustomFeedback = false,

    // If you want to set custom child at the time of drag then set this parameter to true
    bool isCustomChildWhenDragging = false,

    // onWillAccept determine whether the drag object will accept or not. Based on that return a bool.
    @required Function onWillAccept,

    // This method onReorder has two parameters oldIndex and newIndex
    @required Function onReorder,
    EdgeInsetsGeometry padding,
    @required SliverGridDelegate gridDelegate,
    @required IndexedWidgetBuilder itemBuilder,
    int itemCount,
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    bool addSemanticIndexes = true,
    double cacheExtent,
    int semanticChildCount,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    ScrollViewKeyboardDismissBehavior keyboardDismissBehavior =
        ScrollViewKeyboardDismissBehavior.manual,
    bool isCustomDragItem = false,
    // set you feedback child here and to get this working please set isCustomFeedback to true
    Function feedback,
    // set you custom child here and to get this working please set isCustomChildWhenDragging to true
    Function childWhenDragging,
  })  : assert(itemBuilder != null &&
            gridDelegate != null &&
            onReorder != null &&
            onWillAccept != null),
        super(
          key: key,
          reverse: reverse,
          itemBuilder: itemBuilder,
          onWillAccept: onWillAccept,
          feedback: feedback,
          onReorder: onReorder,
          childWhenDragging: childWhenDragging,
          controller: controller,
          isCustomDragItem: isCustomDragItem,
          padding: padding,
          semanticChildCount: semanticChildCount,
          physics: physics,
          addAutomaticKeepAlives: addAutomaticKeepAlives,
          addRepaintBoundaries: addRepaintBoundaries,
          addSemanticIndexes: addSemanticIndexes,
          cacheExtent: cacheExtent,
          itemCount: itemCount,
          primary: primary,
          isCustomFeedback: isCustomFeedback,
          isCustomChildWhenDragging: isCustomChildWhenDragging,
          gridDelegate: gridDelegate,
          dragStartBehavior: dragStartBehavior,
          keyboardDismissBehavior: keyboardDismissBehavior,
          isVertical: false,
        );
}
