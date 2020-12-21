//
//  Item.swift
//  SwiftUI ToDoApp
//
//  Created by 平林宏淳 on 2020/12/20.
//  Copyright © 2020 Hiroaki_Hirabayashi. All rights reserved.
//

import Foundation

struct Item: Identifiable {
  let id: String
  let title: String
  let order: Int
}

extension Item {
  init(itemDB: ItemDB) {
    id = itemDB.id
    title = itemDB.title
    order = itemDB.order
  }
}
