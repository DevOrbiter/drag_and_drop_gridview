#import "DragAndDropGridviewPlugin.h"
#if __has_include(<drag_and_drop_gridview/drag_and_drop_gridview-Swift.h>)
#import <drag_and_drop_gridview/drag_and_drop_gridview-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "drag_and_drop_gridview-Swift.h"
#endif

@implementation DragAndDropGridviewPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftDragAndDropGridviewPlugin registerWithRegistrar:registrar];
}
@end
