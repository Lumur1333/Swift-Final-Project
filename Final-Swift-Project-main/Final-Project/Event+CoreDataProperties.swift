//
//  Event+CoreDataProperties.swift
//  Final-Project-Adam-Section
//
//  Created by Adam Mcnown on 2020-12-14.
//  Copyright © 2020 Adam McNown. All rights reserved.
//
//

import Foundation
import CoreData


extension Event {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Event> {
        return NSFetchRequest<Event>(entityName: "Event")
    }

    @NSManaged public var date: Date?
    @NSManaged public var event: String?
    @NSManaged public var name: String?
    @NSManaged public var gifts: NSSet?

}

// MARK: Generated accessors for gifts
extension Event {

    @objc(addGiftsObject:)
    @NSManaged public func addToGifts(_ value: GiftDetails)

    @objc(removeGiftsObject:)
    @NSManaged public func removeFromGifts(_ value: GiftDetails)

    @objc(addGifts:)
    @NSManaged public func addToGifts(_ values: NSSet)

    @objc(removeGifts:)
    @NSManaged public func removeFromGifts(_ values: NSSet)

}
