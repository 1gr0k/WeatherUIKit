//
//  CollectionViewCell.swift
//  MSTest
//
//  Created by Андрей Калямин on 01.07.2021.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var iconLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    
    weak var viewModel: CollectionCellViewModel? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            hourLabel.text = viewModel.hour
            iconLabel.text = viewModel.icon
            tempLabel.text = viewModel.temp + "ºC"
        }
    }
}
