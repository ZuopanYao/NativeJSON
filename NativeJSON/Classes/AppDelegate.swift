//
//  AppDelegate.swift
//  NativeJSON
//
//  Created by Harvey on 2017/10/13.
//  Copyright © 2017年 Harvey. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        jsonBase()
        jsonComplex()
        
        //============================ NOTE =====================================
        // 1、模型需要继承Codable协议。
        // 2、某些字段不确定是否有值的时，需要将模型中相应的字段定义为Optional, 这告诉JSONEncoder/JSONDecoder此字段没有值时不用拆包，否则将导致crash的发生。
        // 3、模型嵌套模型时，所涉及到的模型都要继承Codable协议。
        // 4、有时候json数据中的key不一定和我的们模型中的字段名一样，这时候我们就要做关联。如何关联请参考： UserModel
        
        return true
    }

    // 简单的json转换
    func jsonBase() {
        
        // JSON编码 ---> 将[模型]转成JSON字符串
        let user = UserModel(name: "Harvey", age: 18, email: "yaozuopan@icloud.com")
        
        if let jsonData = try? JSONEncoder().encode(user)  { // 编码成功
            
            if let jsonString = String(data: jsonData, encoding: String.Encoding.utf8) {
                
                print("----------------Base--------------------")
                print(jsonString)
            }
        }
        
        // JSON解码 ---> 将JSON字符串转成[模型]
        let jsonString = "{\"userName\":\"HarveyCC\",\"age\":20,\"userEmail\":\"yaozuopan@icloud.com\"}"
        
        if let jsonData = jsonString.data(using: String.Encoding.utf8) { // 解码成功
            
            if let user = try? JSONDecoder().decode(UserModel.self, from: jsonData) {
                
                print("----------------Base--------------------")
                print(user.name, user.age, user.email)
            }
        }
    }
    
    // 模型包含模型的json转换
    func jsonComplex() {
        
        // JSON编码 ---> 将[模型]转成JSON字符串
        let group = Department(name: "软件部", id: 889)
        let user1 = UserModel(name: "Harvey", age: 18, email: "Harvey@icloud.com")
        let user2 = UserModel(name: "Jojo", age: 25, email: "Jojo@icloud.com")
        group.member = [user1, user2];
        
        if let jsonData = try? JSONEncoder().encode(group)  { // 编码成功
            
            if let jsonString = String(data: jsonData, encoding: String.Encoding.utf8) {
                
                print("----------------Complex--------------------")
                print(jsonString)
            }
        }
        
        // JSON解码 ---> 将JSON字符串转成[模型]
        let jsonString = "{\"name\":\"软件部\",\"id\":888,\"member\":[{\"userName\":\"Yoyo\",\"age\":18,\"userEmail\":\"Yoyo@icloud.com\"},{\"userName\":\"Jackly\",\"age\":25,\"userEmail\":\"Jackly@icloud.com\",\"qq\":\"6554866\"}]}"
        
        if let jsonData = jsonString.data(using: String.Encoding.utf8) { // 解码成功
            
            if let group = try? JSONDecoder().decode(Department.self, from: jsonData) {
                
                print("----------------Complex--------------------")
                print(group.name, group.id, group.member.count)
                print(group.member[0].name, group.member[0].age, group.member[0].email, group.member[0].qq ?? "nil")
                print(group.member[1].name, group.member[1].age, group.member[1].email, group.member[1].qq ?? "nil")
            }
        }
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

