//
//  DetailViewController.swift
//  MSTest
//
//  Created by Андрей Калямин on 01.07.2021.
//

import UIKit

class DetailViewController: UIViewController {
    
    //var viewModel: DetailViewModel?

    @IBOutlet weak var cityNameLabel: UILabel!
    
    var viewModel: DetailViewModel?
        
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        setLabels()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
        //cityNameLabel.text = viewModel
    }
    
    func setLabels() {
        guard let viewModel = viewModel else { return }
        self.cityNameLabel.text = viewModel.cityName
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
