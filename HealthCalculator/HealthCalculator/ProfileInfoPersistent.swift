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
            print(context)
        } catch let error {
            debugPrint("Data saving error: \(error)")
        }
        
    }
    
    static func fetchProfileInfo(login: String) -> ProfileInfoModel {
        let request = ProfileInfo.fetchRequest()
        let objects = try! context.fetch(request)
        guard let profileEntity = objects.first(where: { $0.login == login }) else
        { return ProfileInfoModel() }
        return ProfileInfoModel(profileInfo: profileEntity)
        //        do {
        //            let objects = try context.fetch(request)
        //            guard let profileEntity = objects.first(where: { $0.login == login }) else { return ProfileInfoModel() }
        //            return ProfileInfoModel(profileInfo: profileEntity)
        //        } catch let error {
        //            debugPrint("Fetch data error: \(error)")
        //            return ProfileInfoModel()
        //        }
    }
    
    static func updateProfileInfo(with profile: ProfileInfoModel) {
        
        let request = ProfileInfo.fetchRequest()
        let objects = try! context.fetch(request)
        guard let profileEntity = objects.first(where: { $0.login == profile.login }) else { return }
        profileEntity.calories = profile.calories
        profileEntity.proteins = profile.proteins
        profileEntity.fats = profile.fats
        profileEntity.carbohydrate = profile.carbohydrate
        
        do {
            try context.save()
            print("Successfully saved")
        } catch let error {
            debugPrint("Save data error: \(error)")
        }
    }
    
    static func delete(from login: String) {
        do {
            let request = ProfileInfo.fetchRequest()
            let objects = try! context.fetch(request)
            guard let profileEntity = objects.first(where: { $0.login == login }) else { return }
            context.delete(profileEntity)
            try context.save()

        } catch {
            print("Delete image error: \(error)")
        }
        
    }
    
    
//    private static func findAndConvert(login: String, entity: [ProfileInfo]) -> ProfileInfoModel {
//        guard let profileInfo = entity.first(where: { $0.login == login }) else { return ProfileInfoModel() }
//        return ProfileInfoModel(profileInfo: profileInfo)
//    }
}
