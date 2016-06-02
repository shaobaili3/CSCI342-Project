//
//  Session+CoreDataProperties.swift
//  iOS-Project
//
//  Created by SABai on 2/06/2016.
//  Copyright © 2016 Shaobai Li. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Session {

    @NSManaged var day: String?
    @NSManaged var detail: String?
    @NSManaged var i: NSNumber?
    @NSManaged var img: String?
    @NSManaged var img2: String?
    @NSManaged var my: NSNumber?
    @NSManaged var name: String?
    @NSManaged var num: String?
    @NSManaged var start: String?
    @NSManaged var time: String?
    @NSManaged var topic: String?

}
