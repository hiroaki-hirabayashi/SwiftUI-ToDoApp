//
//  Realm.swift
//  SwiftUI ToDoApp
//
//  Created by 平林宏淳 on 2020/12/18.
//  Copyright © 2020 Hiroaki_Hirabayashi. All rights reserved.
//

import RealmSwift

// RealmのDB
class ItemDB: Object {
    @objc dynamic var title = ""
    @objc dynamic var id = ""
    @objc dynamic var order = 0
    
    // 主キーを使うと、データの更新や削除に便利
    override static func primaryKey() -> String? {
        "id"
    }
    
}
