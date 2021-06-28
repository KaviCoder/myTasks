//
//  myData.swift
//  myTasks
//
//  Created by Kavya Joshi on 2/24/21.
//

import Foundation
import CoreData

struct MyData
{
    var dateCreated : Date
    var category : String = MyConstants.categories[0]
    var alarm : Bool = false
    var occurrence : String = "Daily"
    var taskName : String
}



