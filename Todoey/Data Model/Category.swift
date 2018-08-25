//
//  Category.swift
//  Todoey
//
//  Created by Rachit Chauhan on 19/08/18.
//  Copyright © 2018 Rachit Chauhan. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object {
    
    @objc dynamic var name : String = ""
    let items = List<Item>()                    // Declaring Array // Forward relationship meaning that each category has items
    
}
