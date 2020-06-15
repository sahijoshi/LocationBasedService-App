////
////  HomeViewController.swift
////  LBSAR
////
////  Created by skj on 8.3.2020.
////  Copyright © 2020 skj. All rights reserved.
////
//
//import UIKit
//
//class HomeViewController: UIViewController {
//    @IBOutlet weak var collectionView: UICollectionView!
//
//    var dataArr: [String: String] = ["cafe": "Cafe",
//                                     "hospital": "Hospital",
//                                     "supermarket": "Super Market",
//                                     "school": "School",
//                                     "amusement_park": "Amusement Park",
//                                     "bank": "Banks",
//                                     "pharmacy": "Pharmacy",
//                                     "restaurant": "Restaurants",
//                                     "bicycle_store": "Bicycle Store",
//                                     "bus_station": "Bus Station",
//                                     "car_rental": "Car Rental",
//                                     "gas_station": "Gas Station"
//                                    ]
//    
//    var keys = [String]()
//    var data = [HomeItem]()
//
//    let sectionInset:CGFloat = CGFloat(Constants.Preferences.collectionViewSectionInset)
//    let minimumCellSpacing:CGFloat = CGFloat(Constants.Preferences.collectionViewMinmCellSpacing)
//    var searchKey = ""
//    var searchName = ""
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        configureUIs()
//        prepareData()
//    }
//
//    private func prepareData() {
//        keys = Array(dataArr.keys)
//        for key in keys {
//            let homeItem = HomeItem()
//            homeItem.itemTitle = dataArr[key]!
//            homeItem.key = key
//            data.append(homeItem)
//        }
//        collectionView.reloadData()
//    }
//
//    private func configureUIs() {
//        collectionView.layer.cornerRadius = 5
//        collectionView.backgroundColor = UIColor(red: 252, green: 252, blue: 252)
//        collectionView.contentInsetAdjustmentBehavior = .automatic
//
//        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//        layout.sectionInset = UIEdgeInsets(top: sectionInset, left: sectionInset, bottom: sectionInset, right: sectionInset)
//        layout.minimumInteritemSpacing = minimumCellSpacing
//        layout.minimumLineSpacing = minimumCellSpacing + 10
//        collectionView.collectionViewLayout = layout
//    }
//
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let aDestinationVC = segue.destination as? NearbyPlacesViewController {
//            let aHomeItem = sender as! HomeItem
//            aDestinationVC.aHomeItem = aHomeItem
//        }
//    }
//
//}
//
//extension HomeViewController: UICollectionViewDataSource {
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return keys.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCell", for: indexPath) as! HomeCell
//        let aHomeItem = data[indexPath.row]
//        cell.homeItem = aHomeItem
//        return cell
//    }
//}
//
//// MARK: UICollectionViewDelegateFlowLayout delegate methods
//
//extension HomeViewController: UICollectionViewDelegateFlowLayout {
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        let width = UIScreen.main.bounds.size.width
//        if UIApplication.shared.statusBarOrientation.isLandscape  {
//            return CGSize(width: (width - 20 - sectionInset * 2 - minimumCellSpacing * 3)/4, height: (width - 20 - sectionInset * 2 - minimumCellSpacing * 3)/4)
//        }
//
//        return CGSize(width: (width - 20 - sectionInset * 2 - minimumCellSpacing * 3)/3, height: (width - 20 - sectionInset * 2 - minimumCellSpacing * 3)/3)
//    }
//
//}
//
//// MARK: UICollectionViewDelegate Delegate methods
//
//extension HomeViewController: UICollectionViewDelegate {
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let aHomeItem = data[indexPath.row]
//        performSegue(withIdentifier: "NearbyPlacesViewController", sender: aHomeItem)
//    }
//}
//
