//
//  ViewController.swift
//  csc491-hw1-algorithms
//
//  Created by Lew Flauta on 5/8/17.
//  Copyright © 2017 Lew Flauta. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    let cellId = "cellId"

    let values: [CGFloat] = [20,30,40,50,200]

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView?.backgroundColor = .white

        collectionView?.register(BarCell.self, forCellWithReuseIdentifier: cellId)

        (collectionView?.collectionViewLayout as? UICollectionViewFlowLayout)?.scrollDirection = .horizontal
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return values.count
    }

    func maxHeight() -> CGFloat {
        return view.frame.height - 20 - 44 - 8
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! BarCell

        if let max = values.max() {
            let value = values[indexPath.item]
            let ratio = value / max

            cell.barHeightConstraint?.constant = maxHeight() * ratio
        }

        return cell
    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 30, height: maxHeight())
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 4)
    }

}

