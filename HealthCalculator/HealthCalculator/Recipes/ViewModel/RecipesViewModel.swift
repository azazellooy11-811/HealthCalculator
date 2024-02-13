//
//  RecipesViewModel.swift
//  HealthCalculator
//
//  Created by Азалия Халилова on 27.12.2023.
//

import UIKit

protocol RecipesViewModelProtocol {
    var reloadData: (() -> Void)? { get set }
    var showError: ((String) -> Void)? { get set }
    var reloadCell: ((Int) -> Void)? { get set }
    var numberOfCells: Int { get }
    
    func getDish(for row: Int) -> DishCellViewModel
    
}

class RecipesViewModel: RecipesViewModelProtocol {
    // MARK: -  Properties
    var reloadData: (() -> Void)?
    var showError: ((String) -> Void)?
    var reloadCell: ((Int) -> Void)?
    
    var numberOfCells: Int {
        dishes.count
    }
    
    private var dishes: [DishCellViewModel] = [] {
        didSet {
            DispatchQueue.main.async {
                self.reloadData?()
            }
        }
    }
    // MARK: - Life cycle
    init() {
        loadData()
    }
    
    // MARK: - Methods
    func getDish(for row: Int) -> DishCellViewModel {
        return dishes[row]
    }
    
    // MARK: - Private Methods
    private func loadData() {
        ApiManager.getRecipes { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let dishes):
                self.dishes = self.convertToCellViewModel(dishes)
                self.loadImage()
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showError?(error.localizedDescription)
                }
            }
        }
    }
    
    private func loadImage() {
        for (index, dish) in dishes.enumerated() {
            ApiManager.getImageData(url: dish.imageUrl) { [weak self]
                result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let data):
                        self?.dishes[index].imageData = data
                        self?.reloadCell?(index)
                    case .failure(let error):
                        self?.showError?(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    private func convertToCellViewModel(_ dishes: [DishModel]) -> [DishCellViewModel] {
        return dishes.map { DishCellViewModel(dish: $0) }
    }
}
