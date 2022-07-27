//
//  UserCitiesTableViewController.swift
//  Weather
//
//  Created by Владислав Колундаев on 27.07.2022.
//

import UIKit

class UserCitiesTableViewController: UITableViewController {

    var cities: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "City", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = cities[indexPath.row]
        cell.contentConfiguration = content
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            cities.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    @IBAction func addCity(segue: UIStoryboardSegue) {
        if segue.identifier == "addCity" {
            guard let vc = segue.source as? CitiesViewController else { return }
            
            if let indexPath = vc.tableView.indexPathForSelectedRow {
                let city = vc.cities[indexPath.row]
                if !cities.contains(city) {
                    cities.append(city)
                    tableView.reloadData()
                }
            }
        }
    }
}
