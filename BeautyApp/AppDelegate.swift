//
//  AppDelegate.swift
//  BeautyApp
//
//  Created by Jasper Stokman on 01/03/16.
//  Copyright © 2016 Jasper Stokman. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        Parse.enableLocalDatastore()
        
        Parse.setApplicationId("ZChedzYek6Rx87NYKSMuLqnSmqEqjE6fkP2WT55Z", clientKey: "ISKwHAff0789qqZkKAjoKmunT1XpJZn2Ja2yRsZ4"); PFTwitterUtils.initialize(withConsumerKey: "0pEMBo5V2mymALFUTwYV5w95e", consumerSecret:"mjbUvg9dg7JHRfG9TCKkbiTNVMwXVMhDKSRi9OOU2AMas2J16O")
            PFFacebookUtils.initializeFacebook(applicationLaunchOptions: launchOptions);
        
        return true
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        
        return FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
   
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        FBSDKAppEvents.activateApp()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }



}
