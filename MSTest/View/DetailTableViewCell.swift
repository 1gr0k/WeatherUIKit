//
//  DetailTableViewCell.swift
//  MSTest
//
//  Created by Андрей Калямин on 01.07.2021.
//

import UIKit

class DetailTableViewCell: UITableViewCell {

    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var iconLabel: UILabel!
    
    
    
    
    weak var viewModel: DetailCellViewModel? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            dayLabel.text = viewModel.day
            iconLabel.text = viewModel.icon
            tempLabel.text = viewModel.temp + "ºC"
        }
    }

}
