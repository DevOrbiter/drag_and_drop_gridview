import Flutter
import UIKit

public class SwiftDragAndDropGridviewPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "drag_and_drop_gridview", binaryMessenger: registrar.messenger())
    let instance = SwiftDragAndDropGridviewPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
