//
//  GiftDetails+CoreDataProperties.swift
//  Final-Project-Adam-Section
//
//  Created by Adam Mcnown on 2020-12-14.
//  Copyright © 2020 Adam McNown. All rights reserved.
//
//

import Foundation
import CoreData


extension GiftDetails {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GiftDetails> {
        return NSFetchRequest<GiftDetails>(entityName: "GiftDetails")
    }

    @NSManaged public var idea: String?
    @NSManaged public var location: String?
    @NSManaged public var price: Double
    @NSManaged public var myEvent: Event?

}
