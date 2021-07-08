//
//  DetailViewController.swift
//  MSTest
//
//  Created by Андрей Калямин on 01.07.2021.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var iconLabel: UILabel!
    @IBOutlet weak var mainTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    
    
    @IBOutlet weak var daylyWeatherCollection: UICollectionView!
    @IBOutlet weak var daylyWeatherTable: UITableView!
    
    

    var viewModel: DetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        daylyWeatherCollection.delegate = self
        daylyWeatherCollection.dataSource = self
    
        daylyWeatherTable.dataSource = self
        
        setLabels()
    }
    
    func setLabels() {
        guard let viewModel = viewModel else { return }
        self.iconLabel.text = viewModel.icon
        self.cityNameLabel.text = viewModel.cityName
        self.mainTempLabel.text = String(viewModel.temp)
        self.minTempLabel.text = viewModel.minTemp
        self.maxTempLabel.text = viewModel.maxTemp
    }
    
    
}

extension DetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        print("tapped")
    }

    
}

extension DetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.hourlyWeather.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "hourCell", for: indexPath) as! CollectionViewCell
        cell.viewModel = viewModel?.collectionCellViewModel(indexPath: indexPath)
        return cell
    }
    
    
}

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.dailyWeather.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dayCell", for: indexPath) as! DetailTableViewCell
        cell.viewModel = viewModel?.scrollCellViewModel(indexPath: indexPath)
        return cell
    }
    
    

    
    
}


