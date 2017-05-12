//
//  ViewController.swift
//  csc491-hw1-algorithms
//
//  Created by Lew Flauta on 5/8/17.
//  Copyright © 2017 Lew Flauta. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var viewCollectionView: UICollectionView!
    @IBOutlet weak var textFieldArray: UITextView!
    @IBOutlet weak var lblArrayItems: UITextField!
    @IBOutlet weak var sliderNewArray: UISlider!
    @IBOutlet weak var btnSelection: UIButton!
    @IBOutlet weak var btnNewArray: UIButton!
    @IBOutlet weak var btnBubble: UIButton!
    @IBOutlet weak var btnInsertion: UIButton!
    @IBOutlet weak var btnMerge: UIButton!
    @IBOutlet weak var barView: UICollectionView!
    @IBAction func pressNewArray(_ sender: Any) {

    }
    let cellId = "cell"

    var values: [Int] = [5,4,3,2,1,1,2,2,32,2,24,4,24,2,2,5,23,22,3,12,2]
   // var values: [Int] = [5,4]



    @IBAction func pressInsertionSort(_ sender: Any) {
        algInsertionSort(array: values)
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        lblArrayItems.text = String(values.count)
        textFieldArray.text = String(describing: values)
        barView?.backgroundColor = .white

        barView?.register(BarCell.self, forCellWithReuseIdentifier: cellId)


    }

    func algInsertionSort(array:Array<Any>){
        DispatchQueue.global(qos: .background).async{
        var A:[Int] = array as! [Int]

        self.textFieldArray.text = String(describing: A)

        var key:Int
        var i:Int
        for j:Int in 0...A.count-1{

            key = Int(A[j])
            print(A)
            i = j-1
            while ((i>=0) && (A[i]>key)){
                A[i+1] = A[i]
                i = i - 1

            }
            A[i+1] = key

            sleep(1)

            DispatchQueue.main.async  {
                //self.lblArrayItems.text = String(describing: A)
                self.values = A
                self.updateLabel(A: A)
                self.viewCollectionView.reloadData()
                print (A)
            }
        }
        }
    }


    @IBAction func pressReverseSort(_ sender: Any) {algReverseSort(array: values)
    }

    func algReverseSort(array:Array<Any>){
        DispatchQueue.global(qos: .background).async{
            var A:[Int] = array as! [Int]

            self.textFieldArray.text = String(describing: A)

            var key:Int
            var i:Int
            for j:Int in 0...A.count-1{

                key = Int(A[j])
                print(A)
                i = j-1
                while ((i>=0) && (A[i]<key)){
                    A[i+1] = A[i]
                    i = i - 1
                    
                }
                A[i+1] = key

                sleep(1)

                DispatchQueue.main.async  {
                    //self.lblArrayItems.text = String(describing: A)
                    self.values = A
                    self.updateLabel(A: A)
                    self.viewCollectionView.reloadData()
                    print (A)
                }
            }
        }
    }


    //RANDOMIZE ARRAY

    @IBAction func pressRandomize(_ sender: Any) {
        algRandomizeSort(array: values)
    }

    func algRandomizeSort(array:Array<Any>){
        DispatchQueue.global(qos: .background).async{
            var A:[Int] = array as! [Int]

            self.textFieldArray.text = String(describing: A)
            let max = array.count
            var key:Int
            var i:Int
            var rand : UInt32
            for j:Int in 0...A.count-1{
                rand = arc4random_uniform(UInt32(max))
                key = Int(A[Int(rand)])
                print(A)
                i = j-1
                while (i>=0){
                    A[i+1] = A[i]
                    i = i - 1

                }
                A[i+1] = key

                sleep(1)

                DispatchQueue.main.async  {
                    //self.lblArrayItems.text = String(describing: A)
                    self.values = A
                    self.updateLabel(A: A)
                    self.viewCollectionView.reloadData()
                    print (A)
                }
            }
        }
    }




//QUICKSORT
    @IBAction func quickSortPressed(_ sender: Any) {
        quicksort(values)
    }

    func quicksort<T: Comparable>(_ a: [T]) -> [T] {

        guard a.count > 1 else { return a }

        let pivot = a[a.count/2]
        let less = a.filter { $0 < pivot }
        let equal = a.filter { $0 == pivot }
        let greater = a.filter { $0 > pivot }
        sleep(1)

        DispatchQueue.main.async  {
            //self.lblArrayItems.text = String(describing: A)
            self.values = a as! [Int]
            self.updateLabel(A: a)
            self.viewCollectionView.reloadData()
            print (self.quicksort(less) + equal + self.quicksort(greater))
        }
        return quicksort(less) + equal + quicksort(greater)


        }



    //COLLECTIONVIEW

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return values.count
    }

    func maxHeight() -> CGFloat {
        return barView.frame.height - 20 - 44 - 8
    }

    func updateLabel(A:Array<Any>) {
        textFieldArray.text = String(describing: A)
    }




    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = barView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! BarCell

        if let max = values.max() {
            let value = values[indexPath.item]
            let ratio = value / max
            cell.widthAnchor.constraint(equalToConstant: 5.0)
            //cell.barHeightConstraint?.constant = maxHeight() * CGFloat(ratio)
            cell.barHeightConstraint?.constant = CGFloat(value) + 2        }

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

