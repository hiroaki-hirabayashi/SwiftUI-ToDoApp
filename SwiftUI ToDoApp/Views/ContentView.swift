//
//  ContentView.swift
//  SwiftUI ToDoApp
//
//  Created by 平林宏淳 on 2020/12/17.
//  Copyright © 2020 Hiroaki_Hirabayashi. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  @EnvironmentObject var store: ItemStore

  var body: some View {
    ItemListView(items: store.items)
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
