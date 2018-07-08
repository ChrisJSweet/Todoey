//
//  Item.swift
//  Todoey
//
//  Created by Chris Sweet on 14/5/18.
//  Copyright © 2018 Rita Sweet. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date?
    
    // this is the inverse relationship back to the parent category
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
