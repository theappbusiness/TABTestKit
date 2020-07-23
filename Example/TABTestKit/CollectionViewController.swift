//
//  CollectionViewController.swift
//  TABTestKit_Example
//
//  Created by Kane Cheshire on 11/10/2019.
//  Copyright © 2019 Kin + Carta. All rights reserved.
//

import UIKit

final class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.accessibilityIdentifier = "CollectionView"
    collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 50
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
    cell.layer.cornerRadius = 8
    cell.accessibilityIdentifier = "CollectionCell \(indexPath.row)"
    cell.backgroundColor = UIColor(white: 0, alpha: 0.15)
    cell.contentView.subviews.forEach { $0.removeFromSuperview() }
    let label = UILabel()
    label.text = "Cell \(indexPath.row)"
    label.sizeToFit()
    cell.contentView.addSubview(label)
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = (view.bounds.width / 2) - 8
    return CGSize(width: width, height: width / 2)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 8
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 8
  }
  
}
