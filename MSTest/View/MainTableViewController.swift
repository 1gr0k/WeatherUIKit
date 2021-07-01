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
        
        viewModel.fetchAllWeather { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return viewModel.numberOfRows()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath) as? MainTableViewCell
        guard let tableViewCell = cell, let viewModel = viewModel else { return UITableViewCell() }
        let cellViewModel = viewModel.cellViewModel(indexPath: indexPath)
        tableViewCell.viewModel = cellViewModel

        return tableViewCell
    }


    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

 override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     guard let viewModel = viewModel else { return }
     viewModel.selectRow(atIndexPath: indexPath)
     performSegue(withIdentifier: "detailSegue", sender: nil)
 }
 
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     guard let identifier = segue.identifier, let viewModel = viewModel else { return }
     
     if identifier == "detailSegue" {
         if let dvc = segue.destination as? DetailViewController {
             dvc.viewModel = viewModel.viewModelForSelectedRow() as! DetailViewModel
         }
     }
 }

}
