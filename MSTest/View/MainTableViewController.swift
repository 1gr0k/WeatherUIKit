//
//  MainTableViewController.swift
//  MSTest
//
//  Created by Андрей Калямин on 30.06.2021.
//

import UIKit

class MainTableViewController: UITableViewController {

    @IBOutlet var viewModel: MainTableViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = editButtonItem
        
        if viewModel.isCitiesEmpty() {
            self.setEditing(true, animated: true)
            self.addCity()
        }
        
        viewModel.fetchAllWeather { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return viewModel?.numberOfRows() ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath) as? MainTableViewCell
        guard let tableViewCell = cell, let viewModel = viewModel else { return UITableViewCell() }
        let cellViewModel = viewModel.cellViewModel(indexPath: indexPath)
        tableViewCell.viewModel = cellViewModel
        return tableViewCell
    }


 override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     guard let viewModel = viewModel else { return }
     viewModel.selectRow(atIndexPath: indexPath)
     performSegue(withIdentifier: "detailSegue", sender: nil)
 }
 
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     guard let identifier = segue.identifier, let viewModel = viewModel else { return }
     
     if identifier == "detailSegue" {
         if let dvc = segue.destination as? DetailViewController {
            dvc.viewModel = viewModel.viewModelForSelectedRow()!
         }
     }
 }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            viewModel.deleteCity(row: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        default:
            return
        }
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: true)
        if (self.isEditing) {
            navigationItem.leftBarButtonItem =
                UIBarButtonItem(barButtonSystemItem: .add, target: self,
                                action: #selector(addCity))
            
        } else {
            let newButton = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: navigationController, action: nil)
            navigationItem.leftBarButtonItem = newButton
            self.tableView.reloadData()
        }

    }
    
    @objc func addCity() {
        let alert = UIAlertController(title: "Some Title", message: "Enter a text", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Enter the city"
            
        }
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            guard let text = textField?.text, text.count>0 else {
                return }
            DispatchQueue.main.async {
                self.viewModel.addCity(city: text)
            }
            
            self.isEditing.toggle()
            self.tableView.reloadData()
        }))
        self.present(alert, animated: true, completion: nil)
        
    }

}
