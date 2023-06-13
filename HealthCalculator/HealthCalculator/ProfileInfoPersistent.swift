//
//  ProfileInfoPersistent.swift
//  HealthCalculator
//
//  Created by Азалия Халилова on 13.06.2023.
//

import Foundation
import CoreData

final class ProfileInfoPersistent {
    private static let context = AppDelegate.persistentContainer.viewContext
    
    static func save(_ profileInfo: ProfileInfoModel?) {
        guard let description = NSEntityDescription.entity(forEntityName: "ProfileInfo",
                                                           in: context) else { return }
        let entity = ProfileInfo(entity: description,
                                 insertInto: context)
        
        entity.login = profileInfo?.login
        entity.firstName = profileInfo?.firstName
        entity.lastName = profileInfo?.lastName
        entity.calories = profileInfo?.calories
        entity.proteins = profileInfo?.proteins
        entity.fats = profileInfo?.fats
        entity.carbohydrate = profileInfo?.carbohydrate
        
        do {
            try context.save()
        } catch let error {
            debugPrint("Save data error: \(error)")
        }
    }
    
    static func delete(_ profileInfo: ProfileInfoModel) {
        
    }
    
    static func fetchProfileInfo(login: String) -> ProfileInfoModel {
        let request = ProfileInfo.fetchRequest()
        
        do {
            let objects = try context.fetch(request)
            return findAndConvert(login: login, entity: objects)
        } catch let error {
            debugPrint("Fetch data error: \(error)")
            return ProfileInfoModel()
        }
    }
    
    private static func findAndConvert(login: String, entity: [ProfileInfo]) -> ProfileInfoModel {
        guard let profileInfo = entity.first(where: { $0.login == login }) else { return ProfileInfoModel() }
        return ProfileInfoModel(profileInfo: profileInfo)
    }
}
