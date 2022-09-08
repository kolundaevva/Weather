//
//  WeatherCollectionViewController.swift
//  Weather
//
//  Created by Владислав Колундаев on 27.07.2022.
//

import UIKit
import RealmSwift

class WeatherCollectionViewController: UICollectionViewController {

    private let networkService: Network = WeatherService()
    private let dataManger: Manager = DataManager()
    
    private var weather: List<Weather>!
    private var token: NotificationToken?
    var cityName = ""
    
    private var dateTextCache: [IndexPath: String] = [:]
    
    let queue: OperationQueue = {
        let queue = OperationQueue()
        queue.qualityOfService = .userInteractive
        return queue
    }()
    
    private let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yyyy HH.mm"
        return df
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkService.loadData(city: cityName)
        pairCollectionAndRealm()
    }

    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weather.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Weather", for: indexPath) as! WeatherCollectionViewCell
        let weather = weather[indexPath.row]
        
        let time = getCellDateText(forIndexPath: indexPath, andTimestamp: weather.date)
        cell.configure(temp: weather.temp, time: time)
        
        let getCacheImage = GetCacheImage(url: weather.url)
        let setImageToRow = SetImageToRow(indexPath: indexPath, collectionView: collectionView, cell: cell)
        setImageToRow.addDependency(getCacheImage)
        queue.addOperation(getCacheImage)
        OperationQueue.main.addOperation(setImageToRow)
        
        return cell
    }
    
    //MARK: - Methods
    private func pairCollectionAndRealm() {
        guard let realm = try? Realm(), let city = realm.object(ofType: City.self, forPrimaryKey: cityName) else { return }
        weather = city.weather
        
        token = weather.observe({ [weak self] changes in
            guard let collectionView = self?.collectionView else { return }
            
            switch changes {
            case .initial(_):
                collectionView.reloadData()
                break
            case .update(_, deletions: let deletions, insertions: let insertions, modifications: let modifications):
                collectionView.performBatchUpdates({
                    collectionView.insertItems(at: insertions.map({ IndexPath(row: $0, section: 0) }))
                    collectionView.deleteItems(at: deletions.map({ IndexPath(row: $0, section: 0)}))
                    collectionView.reloadItems(at: modifications.map({ IndexPath(row: $0, section: 0) }))
                }, completion: nil)
                break
            case .error(_):
                fatalError("Something goes wrong")
            }
        })
    }
    
    private func getCellDateText(forIndexPath indexPath: IndexPath, andTimestamp timestamp: Double) -> String {
        if let stringDate = dateTextCache[indexPath] {
            return stringDate
        } else {
            let date = Date(timeIntervalSince1970: timestamp)
            let stringDate = dateFormatter.string(from: date)
            dateTextCache[indexPath] = stringDate
            return stringDate
        }
    }
}
