//
//  NetworkingError.swift
//  HealthCalculator
//
//  Created by Азалия Халилова on 24.08.2023.
//

import Foundation

enum NetworkingError: Error {
    case networkingError(_ error: Error)
    case unknown
}
