//
//  Item.swift
//  Todoey
//
//  Created by Rachit Chauhan on 19/08/18.
//  Copyright © 2018 Rachit Chauhan. All rights reserved.
//

import Foundation
import RealmSwift

class Item : Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var dateCreated: Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")    //Each Item would have a parent category
    
}
