//
//  COurseStore.swift
//  FabiosApp
//
//  Created by Fabio Baser on 07.07.20.
//  Copyright © 2020 Fabio Baser. All rights reserved.
//

import Combine
import Contentful
import SwiftUI

let client = Client(spaceId: "pnl1fnv0hj75", accessToken: "Er-Ed7zOXcejYmJAjE95BSJz5pCrxeDSt9_5lpJlcm0")

func getArray(id: String, completion: @escaping ([Entry]) -> ()) {
    let query = Query.where(contentTypeId: id)

    client.fetchArray(of: Entry.self, matching: query) { result in
        switch result {
        case .success(let array):
            DispatchQueue.main.async {
                completion(array.items)
            }
        case .failure(let error):
            print(error)
        }
    }
}

class CourseStore: ObservableObject {
    @Published var courses: [Course] = courseData
    
    let colors = [#colorLiteral(red: 0.3176470697, green: 0.07450980693, blue: 0.02745098062, alpha: 1),#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1),#colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1),#colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1),#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)]

    init() {
        getArray(id: "course") { items in
            items.forEach { item in
                self.courses.append(Course(
                    title: item.fields["title"] as! String,
                    subtitle: item.fields["subtitle"] as! String,
                    image: item.fields.linkedAsset(at: "image")?.url ?? URL(string: "")!,
                    logo: #imageLiteral(resourceName: "Logo2"),
                    color: self.colors.randomElement()!,
                    show: false
                ))
            }
        }
    }
}
