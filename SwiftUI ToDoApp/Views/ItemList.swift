//
//  ItemList.swift
//  SwiftUI ToDoApp
//
//  Created by 平林宏淳 on 2020/12/20.
//  Copyright © 2020 Hiroaki_Hirabayashi. All rights reserved.
//

import SwiftUI

struct ItemListView: View {
    @EnvironmentObject var store: ItemStore
    @State var title = ""
    var items: [Item]
    
    var body: some View {
        VStack {
            EditButton()
                .padding(.top)
            HStack {
              TextField("タイトルの入力", text: $title)
                .textFieldStyle(RoundedBorderTextFieldStyle())
              Button("決定", action: create)
            }
            .padding(.leading)
            .padding(.trailing)
            
            List {
              ForEach(items) { item in
                HStack {
                  Text(item.title)
                  Spacer()
                }
              }
              .onDelete { offsets in
                self.delete(offsets: offsets)
              }
                .onMove { source, destination in
                    self.move(sourceIndexSet: source, destination: destination)
                }
            }
        }
    }
}

extension ItemListView {
    private func create() {
        store.create(title: self.title, order: items.count)
        self.title = ""
    }
    
    
    private func delete(offsets: IndexSet) {
        guard let index = offsets.first else {
            return
        }
        // 削除する行のIDを取得
        let deleteId = items[index].id
        // 削除する行の行番号を取得
        let deleteOrder = items[index].order
        // 削除する行の行番号より大きい行番号を全て -1 する
        for i in (deleteOrder + 1)..<items.count {
            store.update(id: items[i].id, order: items[i].order - 1)
        }
        // 行を削除する
        store.delete(id: deleteId)
    }
    
    private func move(sourceIndexSet: IndexSet, destination: Int) {
        store.move(sourceIndexSet: sourceIndexSet, destination: destination)
    }
}


