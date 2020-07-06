//
//  UpdateStore.swift
//  FabiosApp
//
//  Created by Fabio Baser on 07.07.20.
//  Copyright © 2020 Fabio Baser. All rights reserved.
//

import SwiftUI
import Combine

class UpdateStore : ObservableObject {
    @Published var updates : [Update] = updateData
}
