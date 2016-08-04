//
//  AppDelegate.swift
//  lol champions 1
//
//  Created by Supratim Baruah on 11/30/14.
//  Copyright (c) 2014 Supratim Baruah. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var dict_FavChamps: NSMutableDictionary = NSMutableDictionary.alloc()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentDirectoryPath = paths[0] as String
        let plistFile2PathInDocumentDirectory = documentDirectoryPath + "/FavoriteChampions.plist"
        
        // NSMutableDictionary manages an *unordered* collection of mutable (changeable) key-value pairs.
        // Instantiate an NSMutableDictionary object and initialize it with the contents of the CountryCities.plist file.
        var dictionary2FromFile: NSMutableDictionary? = NSMutableDictionary(contentsOfFile: plistFile2PathInDocumentDirectory)
        
        /*
        If the optional variable dictionaryFromFile has a value, then
        CountryCities.plist exists in the Document directory and the dictionary is successfully created
        else read CountryCities.plist from the application's main bundle.
        */
        if let dictionary2FromFileInDocumentDirectory = dictionary2FromFile {
            
            // CountryCities.plist exists in the Document directory
            dict_FavChamps = dictionary2FromFileInDocumentDirectory
            
        } else {
            
            // CountryCities.plist does not exist in the Document directory; Read it from the main bundle.
            
            // Obtain the file path to the plist file in the mainBundle (project folder)
            var plistFile2PathInMainBundle = NSBundle.mainBundle().pathForResource("FavoriteChampions", ofType: "plist")
            
            // Instantiate an NSDictionary object and initialize it with the contents of the CountryCities.plist file.
            var dictionary2FromFileInMainBundle: NSMutableDictionary? = NSMutableDictionary(contentsOfFile: plistFile2PathInMainBundle!)
            
            // Typecast the created NSDictionary as Dictionary type and assign it to the property
            dict_FavChamps = dictionary2FromFileInMainBundle!
            
        }

        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
        // Define the file path to the CountryCities.plist file in the Document directory
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentDirectoryPath = paths[0] as String
        let plistFilePathInDocumentDirectory = documentDirectoryPath + "/FavoriteChampions.plist"

    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

