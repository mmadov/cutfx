import UIKit
import Flutter
import flutter_local_notifications
import GoogleMaps
import Firebase

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      GMSServices.provideAPIKey("AIzaSyDMku6zGXg_EWPZgT2aVxnqXgQmm55tPr4")
          FirebaseApp.configure() //add this before the code below
          GeneratedPluginRegistrant.register(with: self)
      if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
          }
            FlutterLocalNotificationsPlugin.setPluginRegistrantCallback { (registry) in
                GeneratedPluginRegistrant.register(with: registry)
             }
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
