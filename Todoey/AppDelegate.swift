//
//  AppDelegate.swift
//  Todoey
//
//  Created by Rachit Chauhan on 06/08/18.
//  Copyright © 2018 Rachit Chauhan. All rights reserved.
//

import UIKit
import  RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //print(Realm.Configuration.defaultConfiguration.fileURL)
       
        

        do {
            _ = try Realm()
        
            }
        catch {
            print("Error initialising new Realm \(error)")
        }
        
        
        
        
        return true
        
        
    }
    
    
}


