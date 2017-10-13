//
//  UserModel.swift
//  NativeJSON
//
//  Created by Harvey on 2017/10/13.
//  Copyright © 2017年 Harvey. All rights reserved.
//

import Foundation

class UserModel: Codable {
 
    var name: String
    var age: Int
    var email: String
    var qq: String? = nil     // Optional

    init(name: String, age: Int, email: String) {
        
        self.name = name
        self.age = age
        self.email = email
    }
    
    enum CodingKeys : String, CodingKey { // 有时候json数据中的key不一定和我的们模型中的字段名一样，这时候我们就要做关联
                                          // 注意1:CodingKeys是固定的枚举的名称，不能自定义。
        case name = "userName"            // 注意2:一旦定义了CodingKeys，JSONEncoder/JSONDecoder将根据CodingKeys去工作
        case age                          //      没有在CodingKeys中的字段将被过滤掉了
        case email = "userEmail"
        case qq
    }
}

class Department: Codable {
    
    var name: String
    var id: Int
    var member: [UserModel] = []
    
    init(name: String, id: Int) {
        
        self.name = name;
        self.id = id;
    }
}
