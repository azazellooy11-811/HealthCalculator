//
//  ProfileViewModel.swift
//  HealthCalculator
//
//  Created by Азалия Халилова on 13.06.2023.
//

import UIKit

protocol ProfileViewModelProtocol {
    var profileInfo: ProfileInfoModel { get }
}

final class ProfileViewModel: ProfileViewModelProtocol {
    var profileInfo: ProfileInfoModel
    
    init(profileInfo: ProfileInfoModel) {
        self.profileInfo = profileInfo
    }
}
