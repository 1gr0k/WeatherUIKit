//
//  MainTableViewCell.swift
//  MSTest
//
//  Created by Андрей Калямин on 30.06.2021.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    @IBOutlet weak var cityNameLabel: UILabel!
    
    weak var viewModel: MainTableCellViewModel? {
        
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            cityNameLabel.text = viewModel.cityName
        }
    }
}
