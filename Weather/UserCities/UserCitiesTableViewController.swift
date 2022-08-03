//
//  UserCitiesTableViewController.swift
//  Weather
//
//  Created by Владислав Колундаев on 27.07.2022.
//

import UIKit
import RealmSwift

class UserCitiesTableViewController: UITableViewController {

    var cities: Results<City>?
    var token: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pairTableAndRealm()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "City", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = cities?[indexPath.row].name
        cell.contentConfiguration = content
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let city = cities?[indexPath.row] else { return }
        
        if editingStyle == .delete {
            do {
                let realm = try Realm()
                try realm.write {
                    realm.delete(city.weather)
                    realm.delete(city)
                }
            } catch {
                print(error)
            }
        }
    }
    
    //MARK: - Methods
    private func pairTableAndRealm() {
        guard let realm = try? Realm() else { return }
        cities = realm.objects(City.self)
        
        token = cities?.observe({ [weak self] changes in
            guard let tableView = self?.tableView else { return }
            
            switch changes {
            case .initial(_):
                tableView.reloadData()
                break
            case .update(_, deletions: let deletions, insertions: let insertions, modifications: let modifications):
                tableView.beginUpdates()
                tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }),
                                     with: .automatic)
                tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}),
                                     with: .automatic)
                tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }),
                                     with: .automatic)
                tableView.endUpdates()
                break
            case .error(_):
                fatalError("Something goes wrong")
            }
        })
    }
    
    private func showAddCityForm() {
        let ac = UIAlertController(title: "Add city form", message: "Enter city name", preferredStyle: .alert)
        ac.addTextField()
        let add = UIAlertAction(title: "Add", style: .default) { [weak self] _ in
            guard let cityName = ac.textFields?[0].text else { return }
            self?.addCity(name: cityName)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .default)
        ac.addAction(add)
        ac.addAction(cancel)
        
        present(ac, animated: true)
    }
    
    private func addCity(name: String) {
        let city = City()
        city.name = name
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(city, update: .modified)
            }
        } catch {
            print(error)
        }
    }
    
    @IBAction func cityAddPressed(_ sender: Any) {
        showAddCityForm()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showWeather" {
            guard let vc = segue.destination as? WeatherCollectionViewController, let cell = sender as? UITableViewCell else { return }
            if let index = tableView.indexPath(for: cell) {
                vc.cityName = cities?[index.row].name ?? "Moscow"
            }
        }
    }
}
