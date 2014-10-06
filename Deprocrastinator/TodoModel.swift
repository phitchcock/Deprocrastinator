//
//  TodoModel.swift
//  Deprocrastinator
//
//  Created by Peter Hitchcock on 10/6/14.
//  Copyright (c) 2014 Peter Hitchcock. All rights reserved.
//

import Foundation
import CoreData

@objc(TodoModel)

class TodoModel: NSManagedObject {

    @NSManaged var item: String

}
