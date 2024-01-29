//
//  TableCollectionViewSection.swift
//  HealthCalculator
//
//  Created by Азалия Халилова on 14.01.2024.
//

import Foundation

protocol TableCollectionViewItemsProtocol { }

struct TableCollectionViewSection {
    var title: String?
    var items: [TableCollectionViewItemsProtocol]
}
