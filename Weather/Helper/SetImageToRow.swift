//
//  SetImageToRow.swift
//  Weather
//
//  Created by Владислав Колундаев on 06.09.2022.
//

import Foundation
import UIKit

class SetImageToRow: Operation {
    private let indexPath: IndexPath
    private weak var collectionView: UICollectionView?
    private var cell: WeatherCollectionViewCell?
    
    init(indexPath: IndexPath, collectionView: UICollectionView, cell: WeatherCollectionViewCell) {
        self.indexPath = indexPath
        self.collectionView = collectionView
        self.cell = cell
    }
    
    override func main() {
        guard let collectionView = collectionView, let cell = cell, let getCahceImage = dependencies[0] as? GetCacheImage, let image = getCahceImage.outputImage else {
//            print("Error here")
            return }
        
        if let newIndexPath = collectionView.indexPath(for: cell), newIndexPath == indexPath {
            print("All good!")
            cell.icon.image = image
        } else if collectionView.indexPath(for: cell) == nil {
            print("All good!123")
            cell.icon.image = image
        }
    }
}
