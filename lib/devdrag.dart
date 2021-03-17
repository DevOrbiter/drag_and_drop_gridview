import 'package:drag_and_drop_gridview/gridorbiter.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class DragAndDropGridView extends MainGridView {
  /// DragAndDropGridView has the all same parameters (except `shrinkWrap` and `scrollDirection`)
  /// that GridView.builder constructor
  ///
  /// Providing a non-null `itemCount` improves the ability of the [GridView] to
  /// estimate the maximum scroll extent.
  ///
  /// `itemBuilder` will be called only with indices greater than or equal to
  /// zero and less than `itemCount`.
  ///
  /// The [gridDelegate] argument must not be null.
  ///
  /// The `addAutomaticKeepAlives` argument corresponds to the
  /// [SliverChildBuilderDelegate.addAutomaticKeepAlives] property. The
  /// `addRepaintBoundaries` argument corresponds to the
  /// [SliverChildBuilderDelegate.addRepaintBoundaries] property. Both must not
  /// be null.
  /// this [onReorder] have the old index and new index. Called when an acceptable piece of data was dropped over this grid child.
  /// [onWillAccept] this funciton allows you to validate if you want to accept the change in the order of the gridViewItems.
  ///  If you always want to accept the change simply return true
  DragAndDropGridView({
    Key? key,
    bool reverse = false,
    Widget? header,
    ScrollController? controller,
    bool? primary,
    ScrollPhysics? physics,
    bool isCustomFeedback = false,
    bool isCustomChildWhenDragging = false,
    required WillAcceptCallback onWillAccept,
    required ReorderCallback onReorder,
    EdgeInsetsGeometry? padding,
    required SliverGridDelegate gridDelegate,
    required IndexedWidgetBuilder itemBuilder,
    int? itemCount,
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    bool addSemanticIndexes = true,
    double? cacheExtent,
    int? semanticChildCount,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    ScrollViewKeyboardDismissBehavior keyboardDismissBehavior =
        ScrollViewKeyboardDismissBehavior.manual,
    WidgetPositionBuilder? feedback,
    WidgetPositionBuilder? childWhenDragging,
  })  : super(
          key: key,
          reverse: reverse,
          header: header,
          itemBuilder: itemBuilder,
          onWillAccept: onWillAccept,
          feedback: feedback,
          onReorder: onReorder,
          childWhenDragging: childWhenDragging,
          controller: controller,
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

  /// This constructor  use to achive the Horizontal Reorderable / Re-Indexing feature in DragAndDropGridView.
  /// Providing a non-null `itemCount` improves the ability of the [GridView] to
  /// estimate the maximum scroll extent.
  ///
  /// `itemBuilder` will be called only with indices greater than or equal to
  /// zero and less than `itemCount`.
  ///
  /// The [gridDelegate] argument must not be null.
  ///
  /// The `addAutomaticKeepAlives` argument corresponds to the
  /// [SliverChildBuilderDelegate.addAutomaticKeepAlives] property. The
  /// `addRepaintBoundaries` argument corresponds to the
  /// [SliverChildBuilderDelegate.addRepaintBoundaries] property. Both must not
  /// be null.
  /// this [onReorder] have the old index and new index. Called when an acceptable piece of data was dropped over this grid child.
  /// [onWillAccept] this funciton allows you to validate if you want to accept the change in the order of the gridViewItems.
  ///  If you always want to accept the change simply return true
  DragAndDropGridView.horizontal({
    Key? key,
    bool reverse = false,
    ScrollController? controller,
    bool? primary,
    ScrollPhysics? physics,
    bool isCustomFeedback = false,
    bool isCustomChildWhenDragging = false,
    required WillAcceptCallback onWillAccept,
    required ReorderCallback onReorder,
    EdgeInsetsGeometry? padding,
    required SliverGridDelegate gridDelegate,
    required IndexedWidgetBuilder itemBuilder,
    int? itemCount,
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    bool addSemanticIndexes = true,
    double? cacheExtent,
    int? semanticChildCount,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    ScrollViewKeyboardDismissBehavior keyboardDismissBehavior =
        ScrollViewKeyboardDismissBehavior.manual,
    WidgetPositionBuilder? feedback,
    WidgetPositionBuilder? childWhenDragging,
  })  : super(
          key: key,
          reverse: reverse,
          itemBuilder: itemBuilder,
          onWillAccept: onWillAccept,
          feedback: feedback,
          onReorder: onReorder,
          childWhenDragging: childWhenDragging,
          controller: controller,
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

  /// To achive the sticky header in gridview just call this stickyHeader constructor.

  /// By Default allHeaderChildNonDraggable is set to false making all header draggable.

  /// [onWillAcceptHeader] (Implement your logic on accepting and rejecting the drop of an header element),

  /// [onReorderHeader] (implement your logic for reodering and reindexing the elements)

  /// And if you want the header to be non-draggable element simple set [allHeaderChildNonDraggable] to true.

  ///  [itemBuilderHeader] will be called only with indices greater than or equal to
  ///
  ///
  /// Providing a non-null `itemCount` improves the ability of the [GridView] to
  /// estimate the maximum scroll extent.
  ///
  /// `itemBuilder` will be called only with indices greater than or equal to
  /// zero and less than `itemCount`.
  ///
  /// The [gridDelegate] argument must not be null.
  ///
  /// The `addAutomaticKeepAlives` argument corresponds to the
  /// [SliverChildBuilderDelegate.addAutomaticKeepAlives] property. The
  /// `addRepaintBoundaries` argument corresponds to the
  /// [SliverChildBuilderDelegate.addRepaintBoundaries] property. Both must not
  /// be null.
  /// this [onReorder] have the old index and new index. Called when an acceptable piece of data was dropped over this grid child.
  /// [onWillAccept] this funciton allows you to validate if you want to accept the change in the order of the gridViewItems.
  ///  If you always want to accept the change simply return true
  DragAndDropGridView.stickyHeader({
    Key? key,
    bool reverse = false,
    ScrollController? controller,
    bool? primary,
    ScrollPhysics? physics,
    bool isCustomFeedback = false,
    bool isCustomChildWhenDragging = false,
    required WillAcceptCallback onWillAccept,
    WillAcceptCallback? onWillAcceptHeader,
    required IndexedWidgetBuilder itemBuilderHeader,
    bool allHeaderChildNonDraggable = false,
    SliverGridDelegate? headerGridDelegate,
    required ReorderCallback onReorder,
    ReorderCallback? onReorderHeader,
    int? headerItemCount,
    EdgeInsetsGeometry? headerPadding,
    EdgeInsetsGeometry? padding,
    required SliverGridDelegate gridDelegate,
    required IndexedWidgetBuilder itemBuilder,
    int? itemCount,
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    bool addSemanticIndexes = true,
    double? cacheExtent,
    int? semanticChildCount,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    ScrollViewKeyboardDismissBehavior keyboardDismissBehavior =
        ScrollViewKeyboardDismissBehavior.manual,
    WidgetPositionBuilder? feedback,
    WidgetPositionBuilder? childWhenDragging,
  })  : super(
          key: key,
          reverse: reverse,
          itemBuilder: itemBuilder,
          onWillAccept: onWillAccept,
          feedback: feedback,
          onReorder: onReorder,
          onReorderHeader: onReorderHeader,
          onWillAcceptHeader: onWillAcceptHeader,
          childWhenDragging: childWhenDragging,
          controller: controller,
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
          itemBuilderHeader: itemBuilderHeader,
          isStickyHeader: true,
          allHeaderChildNonDraggable: allHeaderChildNonDraggable,
          headerPadding: headerPadding,
          headerGridDelegate: headerGridDelegate,
          headerItemCount: headerItemCount,
        );

  /// To achive the sticky header in horizontal gridview just call this horizontalStickyHeader constructor.

  /// By Default allHeaderChildNonDraggable is set to false making all header draggable.

  /// [onWillAcceptHeader] (Implement your logic on accepting and rejecting the drop of an header element),

  /// [onReorderHeader] (implement your logic for reodering and reindexing the elements)

  /// And if you want the header to be non-draggable element simple set [allHeaderChildNonDraggable] to true.

  ///  [itemBuilderHeader] will be called only with indices greater than or equal to
  ///
  ///
  /// Providing a non-null `itemCount` improves the ability of the [GridView] to
  /// estimate the maximum scroll extent.
  ///
  /// `itemBuilder` will be called only with indices greater than or equal to
  /// zero and less than `itemCount`.
  ///
  /// The [gridDelegate] argument must not be null.
  ///
  /// The `addAutomaticKeepAlives` argument corresponds to the
  /// [SliverChildBuilderDelegate.addAutomaticKeepAlives] property. The
  /// `addRepaintBoundaries` argument corresponds to the
  /// [SliverChildBuilderDelegate.addRepaintBoundaries] property. Both must not
  /// be null.
  /// this [onReorder] have the old index and new index. Called when an acceptable piece of data was dropped over this grid child.
  /// [onWillAccept] this funciton allows you to validate if you want to accept the change in the order of the gridViewItems.
  ///  If you always want to accept the change simply return true
  DragAndDropGridView.horizontalStickyHeader({
    Key? key,
    bool reverse = false,
    ScrollController? controller,
    bool? primary,
    ScrollPhysics? physics,
    bool isCustomFeedback = false,
    bool isCustomChildWhenDragging = false,
    required WillAcceptCallback onWillAccept,
    WillAcceptCallback? onWillAcceptHeader,
    required IndexedWidgetBuilder itemBuilderHeader,
    bool allHeaderChildNonDraggable = false,
    SliverGridDelegate? headerGridDelegate,
    required ReorderCallback onReorder,
    ReorderCallback? onReorderHeader,
    int? headerItemCount,
    EdgeInsetsGeometry? headerPadding,
    EdgeInsetsGeometry? padding,
    required SliverGridDelegate gridDelegate,
    required IndexedWidgetBuilder itemBuilder,
    int? itemCount,
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    bool addSemanticIndexes = true,
    double? cacheExtent,
    int? semanticChildCount,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    ScrollViewKeyboardDismissBehavior keyboardDismissBehavior =
        ScrollViewKeyboardDismissBehavior.manual,
    WidgetPositionBuilder? feedback,
    WidgetPositionBuilder? childWhenDragging,
  })  : super(
            key: key,
            reverse: reverse,
            itemBuilder: itemBuilder,
            onWillAccept: onWillAccept,
            feedback: feedback,
            onReorder: onReorder,
            onReorderHeader: onReorderHeader,
            onWillAcceptHeader: onWillAcceptHeader,
            childWhenDragging: childWhenDragging,
            controller: controller,
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
            itemBuilderHeader: itemBuilderHeader,
            isStickyHeader: true,
            allHeaderChildNonDraggable: allHeaderChildNonDraggable,
            headerPadding: headerPadding,
            headerGridDelegate: headerGridDelegate,
            headerItemCount: headerItemCount,
            isVertical: false);
}
