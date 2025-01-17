//
// Copyright © 2020 UnifyID, Inc. All rights reserved.
// Unauthorized copying or excerpting via any medium is strictly prohibited.
// Proprietary and confidential.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    /// Subscribe-able Notification Name that will send device token whenever this instance's application:didRegisterForRemoteNotificationsWithDeviceToken: gets called.
    static let didReceiveDeviceToken = Notification.Name(rawValue: "AppDelegate.didRegisterForRemoteNotificationsWithDeviceToken")
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // UnifyID works with `Data` or `String` tokens, string is easier to use
        let tokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        
        publishNotification(for: tokenString)
        UnifyConfigurationStore.setConfig(key: .deviceToken, value: tokenString)
    }
    
    private func publishNotification(for deviceToken: String) {
        let notification = Notification(name: AppDelegate.didReceiveDeviceToken, object: deviceToken)
        NotificationCenter.default.post(notification)
    }
        
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        log("Failed to register for Remote Notification: \(error)")
    }
}
