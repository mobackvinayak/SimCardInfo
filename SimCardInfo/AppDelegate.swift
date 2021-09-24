//
//  AppDelegate.swift
//  SimCardInfo
//
//  Created by Vinayak Tudayekar on 21/09/21.
//

import UIKit
import CoreTelephony

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let telephonyNetworkInfo = CTTelephonyNetworkInfo()
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        
        if #available(iOS 12, *){
        telephonyNetworkInfo.serviceSubscriberCellularProvidersDidUpdateNotifier = { [weak telephonyNetworkInfo] carrierIdentifier in
            print("Appdelegate Sim card changed")
            
            let alert = UIAlertController(title: "Alert", message:"Appdelegate Sim card changed", preferredStyle: UIAlertController.Style.alert)
                    
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            DispatchQueue.main.async {
            // show the alert
            self.window?.rootViewController?.present(alert, animated: true, completion: nil)
            }
        }
        }else {
            telephonyNetworkInfo.subscriberCellularProviderDidUpdateNotifier = { carrier in
                DispatchQueue.main.async {
                    print("User did change SIM")
                }
            }
        }
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
}

