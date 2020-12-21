//
//  ItemStore.swift
//  SwiftUI ToDoApp
//
//  Created by 平林宏淳 on 2020/12/20.
//  Copyright © 2020 Hiroaki_Hirabayashi. All rights reserved.
//

import RealmSwift

final class ItemStore: ObservableObject {
    
    private var itemResults: Results<ItemDB>
    
    init(realm: Realm) {
        itemResults = realm.objects(ItemDB.self)
            .sorted(byKeyPath: "order") // orderの数値で並び替え
    }
    
    var items: [Item] {
        itemResults.map(Item.init)
    }
}

extension ItemStore {
    // データの追加
    func create(title: String, order: Int) {
        objectWillChange.send()
        
        do {
            let realm = try Realm()
            
            let itemDB = ItemDB()
            itemDB.id = UUID().uuidString
            itemDB.title = title
            itemDB.order = order
            try realm.write {
                realm.add(itemDB)
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    // データの削除
    func delete(id: String) {
        objectWillChange.send()
        
        guard let itemDB = itemResults.first(where: { $0.id == id }) else {
            return
        }
        
        do {
            let realm = try Realm()
            try realm.write {
                realm.delete(itemDB)
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    // データの更新
    func update(id: String, order: Int) {
        objectWillChange.send()
        
        do {
            let realm = try Realm()
            try realm.write {
                realm.create(ItemDB.self,
                             value: ["id": id,
                                     "order": order],
                             update: .modified)
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    // Listを並び替えるための関数
    func move(sourceIndexSet: IndexSet, destination: Int) {
        guard let source = sourceIndexSet.first else {
            return
        }
        
        // 並び替える行のIDを取得
        let moveId = items[source].id
        
        // Listの行を下に移動する場合
        if source < destination {
            for i in (source + 1)...(destination - 1) {
                update(id: items[i].id, order: items[i].order - 1)
            }
            update(id: moveId, order: destination - 1)
            
            // Listの行を上に移動する場合
        } else if destination < source {
            // reversed()で逆から回さないと、一時的にorderの数値が重なり想定外の挙動をする。
            for i in (destination...(source - 1)).reversed() {
                update(id: items[i].id, order: items[i].order + 1)
            }
            update(id: moveId, order: destination)
            
        } else {
            return
        }
    }
}
