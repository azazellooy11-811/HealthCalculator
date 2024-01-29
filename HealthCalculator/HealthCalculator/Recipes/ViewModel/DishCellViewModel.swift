//
//  DishCellViewModel.swift
//  HealthCalculator
//
//  Created by Азалия Халилова on 11.01.2024.
//

import Foundation

struct DishCellViewModel: TableCollectionViewItemsProtocol {
    let title: String
    let imageUrl: String
    
    var imageData: Data?
    
    
    init(dish: DishModel) {
        self.title = dish.title
        self.imageUrl = dish.image
    }
}
