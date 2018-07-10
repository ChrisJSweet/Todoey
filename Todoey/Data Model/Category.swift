//
//  Category.swift
//  Todoey
//
//  Created by Chris Sweet on 14/5/18.
//  Copyright © 2018 Rita Sweet. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var colour: String = ""
    let items = List<Item>()
    }
