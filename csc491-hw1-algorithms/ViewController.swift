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
    @IBOutlet weak var btnInsertion: UIButton!
    @IBOutlet weak var btnMerge: UIButton!
    @IBOutlet weak var barView: UICollectionView!

    @IBOutlet weak var segmented: UISegmentedControl!

//bottom-half outlets

    @IBOutlet weak var array2label: UITextView!
    @IBOutlet weak var viewCollectionView2: UICollectionView!


    let cellId = "cell"

    var values: [Int] = [5,4,3,2,1,2,2,32,2,24,4,24,2,2,5,23,22,3,12,2]
    var values2: [Int] = [5,4,3,2,1,2,2,32,2,24,4,24,2,2,5,23,22,3,12,2]


    override func viewDidLoad() {
        super.viewDidLoad()
        lblArrayItems.text = String(values.count)
        textFieldArray.text = String(describing: values)
        barView?.backgroundColor = .white

        barView?.register(BarCell.self, forCellWithReuseIdentifier: cellId)
    }


    //INSERTION SORT

    @IBAction func pressInsertionSort(_ sender: Any) {
        algInsertionSort(array: values)
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


    //REVERSE INSERTION SORT
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
            let max = A.count
            var key:Int
            var i:Int
            var rand : Int

            for j:Int in 0...A.count-1{
                rand = Int(arc4random_uniform(UInt32(max-1)))
                key = Int(A[j])
                print(A)
                i = j-1
                while (i>=0) {
                    var swapCache = A[i+1]
                    A[i+1] = A[rand]
                    A[rand] = swapCache
                    i = i - 1

                }


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
        mergeSortBottomUp(values, <)

    }

    func mergeSortBottomUp<T>(_ a: [T], _ isOrderedBefore: @escaping (T, T) -> Bool)  {
DispatchQueue.global(qos: .background).async{

        let n = a.count
        var z = [a, a]   // the two working arrays
        var d = 0        // z[d] is used for reading, z[1 - d] for writing
        var width = 1
        while width < n {

            var i = 0
            while i < n {

                var j = i
                var l = i
                var r = i + width

                let lmax = min(l + width, n)
                let rmax = min(r + width, n)

                while l < lmax && r < rmax {
                    if isOrderedBefore(z[d][l], z[d][r]) {
                        z[1 - d][j] = z[d][l]
                        l += 1
                    } else {
                        z[1 - d][j] = z[d][r]
                        r += 1
                    }
                    j += 1
                }
                sleep(1)

                while l < lmax {
                    z[1 - d][j] = z[d][l]
                    j += 1
                    l += 1
                }


                while r < rmax {
                    z[1 - d][j] = z[d][r]
                    j += 1
                    r += 1
                }
                
                i += width*2

                DispatchQueue.main.async  {

                    self.values = z [1] as! [Int]
                    self.updateLabel(A: self.values)
                    self.viewCollectionView.reloadData()
                    print (self.values)
                }
            }
            sleep(1)

            width *= 2   // in each step, the subarray to merge becomes larger
            d = 1 - d    // swap active array
            DispatchQueue.main.async  {

                self.values = z [1] as! [Int]
                self.updateLabel(A: self.values)
                self.viewCollectionView.reloadData()
                print (self.values)
            }
            }
        //return z[d]
        }}

    //***************************
    //BOTTOM HALF
    @IBAction func insertion2Pressed(_ sender: Any) {
        algInsertionSort2(array: values2)
    }

    @IBAction func reverse2Pressed(_ sender: Any) {
        algReverseSort2(array: values2)
    }

    @IBAction func randomize2Press(_ sender: Any) {
        algRandomizeSort2(array: values2)
    }

    @IBAction func merge2Pressed(_ sender: Any) {
        mergeSortBottomUp2(values2,<)
    }

    //INSERTION SORT


    func algInsertionSort2(array:Array<Any>){
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


    //REVERSE INSERTION SORT


    func algReverseSort2(array:Array<Any>){
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



    func algRandomizeSort2(array:Array<Any>){
        DispatchQueue.global(qos: .background).async{
            var A:[Int] = array as! [Int]

            self.textFieldArray.text = String(describing: A)
            let max = A.count
            var key:Int
            var i:Int
            var rand : Int

            for j:Int in 0...A.count-1{
                rand = Int(arc4random_uniform(UInt32(max-1)))
                key = Int(A[j])
                print(A)
                i = j-1
                while (i>=0) {
                    var swapCache = A[i+1]
                    A[i+1] = A[rand]
                    A[rand] = swapCache
                    i = i - 1

                }


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




    //MERGESORT


    func mergeSortBottomUp2<T>(_ a: [T], _ isOrderedBefore: @escaping (T, T) -> Bool)  {
        DispatchQueue.global(qos: .background).async{

            let n = a.count
            var z = [a, a]   // the two working arrays
            var d = 0        // z[d] is used for reading, z[1 - d] for writing
            var width = 1
            while width < n {

                var i = 0
                while i < n {

                    var j = i
                    var l = i
                    var r = i + width

                    let lmax = min(l + width, n)
                    let rmax = min(r + width, n)

                    while l < lmax && r < rmax {
                        if isOrderedBefore(z[d][l], z[d][r]) {
                            z[1 - d][j] = z[d][l]
                            l += 1
                        } else {
                            z[1 - d][j] = z[d][r]
                            r += 1
                        }
                        j += 1
                    }
                    sleep(1)

                    while l < lmax {
                        z[1 - d][j] = z[d][l]
                        j += 1
                        l += 1
                    }


                    while r < rmax {
                        z[1 - d][j] = z[d][r]
                        j += 1
                        r += 1
                    }

                    i += width*2

                    DispatchQueue.main.async  {
                        
                        self.values = z [1] as! [Int]
                        self.updateLabel(A: self.values)
                        self.viewCollectionView.reloadData()
                        print (self.values)
                    }
                }
                sleep(1)
                
                width *= 2   // in each step, the subarray to merge becomes larger
                d = 1 - d    // swap active array
                DispatchQueue.main.async  {
                    
                    self.values = z [1] as! [Int]
                    self.updateLabel(A: self.values)
                    self.viewCollectionView.reloadData()
                    print (self.values)
                }
            }
            //return z[d]
        }}



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




}

