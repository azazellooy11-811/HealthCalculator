//
//  ProfileInfo+CoreDataProperties.swift
//  HealthCalculator
//
//  Created by Азалия Халилова on 13.06.2023.
//
//

import Foundation
import CoreData


extension ProfileInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProfileInfo> {
        return NSFetchRequest<ProfileInfo>(entityName: "ProfileInfo")
    }

    @NSManaged public var imageUrl: URL?
    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var calories: String?
    @NSManaged public var proteins: String?
    @NSManaged public var fats: String?
    @NSManaged public var carbohydrate: String?
    @NSManaged public var login: String?

}

extension ProfileInfo : Identifiable {

}
