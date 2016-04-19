//
//  GoodData+CoreDataProperties.swift
//  MapTrac
//
//  Created by user on 4/18/16.
//  Copyright © 2016 VAD. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension GoodData {

    @NSManaged var descript: String?
    @NSManaged var location: String?
    @NSManaged var name: String?
    @NSManaged var pic: NSData?

}
