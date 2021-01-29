//
//  Task+CoreDataClass.swift
//  Module14
//
//  Created by Андрей Мельник on 29.01.2021.
//
//

import Foundation
import CoreData

@objc(Task)
public class Task: NSManagedObject {
    convenience init () {
        self.init(entity: CoreDataManager.instance.entityForName(entityName: "Task"), insertInto: CoreDataManager.instance.context)
    }
}
