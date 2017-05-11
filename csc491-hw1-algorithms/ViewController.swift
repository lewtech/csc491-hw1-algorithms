//
//  ViewController.swift
//  csc491-hw1-algorithms
//
//  Created by Lew Flauta on 5/8/17.
//  Copyright © 2017 Lew Flauta. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var textFieldArray: UITextView!
    @IBOutlet weak var lblArrayItems: UITextField!
    @IBOutlet weak var sliderNewArray: UISlider!
    @IBOutlet weak var btnSelection: UIButton!
    @IBOutlet weak var btnNewArray: UIButton!
    @IBOutlet weak var btnBubble: UIButton!
    @IBOutlet weak var btnInsertion: UIButton!
    @IBOutlet weak var btnMerge: UIButton!
    @IBOutlet weak var barView: UICollectionView!
    let cellId = "cell"

    let values: [CGFloat] = [10,10,10,10,100,1,2,3,4,5,6,7,8,9,10,11,30,1000,1000]


    override func viewDidLoad() {
        super.viewDidLoad()
        lblArrayItems.text = String(values.count)
        textFieldArray.text = String(describing: values)
        barView?.backgroundColor = .white

        barView?.register(BarCell.self, forCellWithReuseIdentifier: cellId)


    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return values.count
    }

    func maxHeight() -> CGFloat {
        return barView.frame.height - 20 - 44 - 8
    }




    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = barView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! BarCell

        if let max = values.max() {
            let value = values[indexPath.item]
            let ratio = value / max
            cell.widthAnchor.constraint(equalToConstant: 5.0)
            cell.barHeightConstraint?.constant = maxHeight() * ratio
        }

        return cell
    }

//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 10, height: maxHeight())
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 4)
//    }


}

