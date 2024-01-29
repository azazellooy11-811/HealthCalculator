//
//  ProfileViewModel.swift
//  HealthCalculator
//
//  Created by Азалия Халилова on 13.06.2023.
//

import UIKit

protocol ProfileViewModelProtocol {
    var login: String { get set }
}

final class ProfileViewModel: ProfileViewModelProtocol {
    var login: String
    
    init(login: String) {
        self.login = login
    }
}
