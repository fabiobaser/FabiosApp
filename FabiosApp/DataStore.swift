//
//  DataStore.swift
//  FabiosApp
//
//  Created by Fabio Baser on 07.07.20.
//  Copyright © 2020 Fabio Baser. All rights reserved.
//

//import Combine
import SwiftUI

class DataStore: ObservableObject {
    @Published var posts: [Post] = []

    init() {
        getPosts()
    }
    
    func getPosts() {
        Api().getPosts { posts in
            self.posts = posts
        }
    }
}
