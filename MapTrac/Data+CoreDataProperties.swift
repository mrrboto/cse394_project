//
//  Data+CoreDataProperties.swift
//  MapTrac
//
//  Created by user on 4/22/16.
//  Copyright © 2016 VAD. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Data {

    @NSManaged var name: String?
    @NSManaged var pic: NSData?
    @NSManaged var lat: String?
    @NSManaged var lon: String?
    @NSManaged var list: String?
    @NSManaged var descript: String?

}
