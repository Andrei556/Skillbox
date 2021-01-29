//
//  Task+CoreDataProperties.swift
//  Module14
//
//  Created by Андрей Мельник on 29.01.2021.
//
//

import Foundation
import CoreData

extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var isDone: Bool
    @NSManaged public var task: String?

}

extension Task : Identifiable {

}
