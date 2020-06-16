////
////  NearbyPlacesViewController.swift
////  LBSAR
////
////  Created by skj on 9.3.2020.
////  Copyright © 2020 skj. All rights reserved.
////
//
import UIKit
//import GoogleMaps
//import HDAugmentedReality
//
class NearbyPlacesViewController: UIViewController {

//    @IBOutlet weak var googleMaps: GMSMapView!
//    @IBOutlet weak var btnArview: UIButton!
//
    var aHomeItem = HomeItem()
//    var aPlace: Place?
//
//    let locationManager = CLLocationManager()
//    var tappedMarker : GMSMarker?
//    var customInfoWindow : MarkerCustomInfo?
//    var arViewController: ARViewController!
//    var places = [Place]()
//    var loadPOIsOnlyOnce = false
//    var currentLocation: CLLocation?
//
    override func viewDidLoad() {
        super.viewDidLoad()
//        title = "Nearby \(aHomeItem.itemTitle)"

//        configureMap()
    }
}
//
//    func configureMap() {
//         locationManager.delegate = self
//         locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
//         locationManager.startUpdatingLocation()
//         locationManager.requestWhenInUseAuthorization()
//
//         let camera = GMSCameraPosition.camera(withLatitude: 51.50998000, longitude: -0.13370000, zoom: 15.0)
//         googleMaps.camera = camera
//
//         googleMaps.delegate = self
//         googleMaps?.isMyLocationEnabled = true
//         googleMaps.settings.myLocationButton = true
//         googleMaps.settings.compassButton = true
//         googleMaps.settings.zoomGestures = true
//
//        customInfoWindow = MarkerCustomInfo().loadView()
//        customInfoWindow?.delegate = self
//    }
//
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let directionVC = segue.destination as? DirectionViewController {
//            self.aPlace?.curLocation = self.currentLocation
//            directionVC.aHomeItem = self.aHomeItem
//            directionVC.aPlace = self.aPlace
//        }
//    }
//
//    // MARK: - Private Methods
//
//    private func setupCameraPosition() {
//        let camera = GMSCameraPosition.camera(withLatitude: currentLocation!.coordinate.latitude, longitude: currentLocation!.coordinate.longitude, zoom: 15.0)
//        googleMaps.animate(to: camera)
//    }
//
//    private func loadNearbyPlacesData() {
//        ApiHandler.loadNearbyPointOfInterest(location: currentLocation!, radius: Constants.Preferences.mapRadius, searchKey: aHomeItem.key) { (placeDataArr) in
//            DispatchQueue.main.async {
//                self.plotMarkersOnMapWith(placeDataArr)
//            }
//        }
//    }
//
//// display markers based on coordinates received from nearby places.
//
//    private func plotMarkersOnMapWith(_ placeDataArr: [Place]) {
//        self.places = placeDataArr
//        for place in placeDataArr {
//            let marker = MyMarker()
//            let image = UIImage(named: aHomeItem.key)
//
//            marker.position = CLLocationCoordinate2DMake(place.latitude!, place.longitude!)
//            marker.place = place
//            marker.icon = image
//            marker.map = self.googleMaps
//        }
//    }
//
//    private func displayPlaceInformationAt(_ position:CLLocationCoordinate2D, aPlace: Place, for mapView: GMSMapView) {
//        self.aPlace = aPlace
//
//        customInfoWindow?.center = mapView.projection.point(for: position)
//        customInfoWindow?.center.y -= 100
//        customInfoWindow?.lblClose.text = aPlace.openNow ? "Open" : "Close"
//        customInfoWindow?.lblTitle.text = aPlace.placeName
//        customInfoWindow?.lblDistance.text = "Total User Rating: \(aPlace.userTotalRating)"
//
//        customInfoWindow?.imagePlace.sd_setImage(with: URL.init(string: aPlace.imageUrl)!, placeholderImage: UIImage(named: "Placeholder"), options: .highPriority)
//        customInfoWindow?.ratingView.rating = aPlace.rating
//
//        googleMaps.addSubview(customInfoWindow!)
//    }
//
//    // MARK: - IBAction Methods
//
//    @IBAction func showARController(_ sender: Any) {
//        arViewController = ARViewController()
//        arViewController.dataSource = self
//        arViewController.trackingManager.userDistanceFilter = 25
//        arViewController.trackingManager.reloadDistanceFilter = 75
//
//        if let presenter = arViewController.presenter {
//            presenter.presenterTransform = ARPresenterStackTransform()
//            presenter.maxDistance = 0
//            presenter.maxVisibleAnnotations = 30
//        }
//
//        let trackingManager = arViewController.trackingManager
//        trackingManager.userDistanceFilter = 15
//        trackingManager.reloadDistanceFilter = 50
//        trackingManager.filterFactor = 0.4
//        trackingManager.minimumTimeBetweenLocationUpdates = 2
//
//        arViewController.setAnnotations(places)
//
//        arViewController.modalPresentationStyle = .fullScreen
//        present(arViewController, animated: true, completion: nil)
//    }
//}
//
//// MARK: - CLLocationManagerDelegate Methods
//
//extension NearbyPlacesViewController: CLLocationManagerDelegate {
//
//    func locationManagerShouldDisplayHeadingCalibration(_ manager: CLLocationManager) -> Bool {
//        return true
//    }
//
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//
//        if !locations.isEmpty {
//            // get current location
//            currentLocation = locations.last!
//            if currentLocation!.horizontalAccuracy < 100 {
//                manager.stopUpdatingLocation()
//
//                if !loadPOIsOnlyOnce {
//                    setupCameraPosition()
//                    loadNearbyPlacesData()
//                    loadPOIsOnlyOnce = true
//                }
//            }
//        }
//    }
//}
//
//// MARK: - ARDataSource Methods
//
//extension NearbyPlacesViewController: ARDataSource {
//
//    // plot customized marker on  Augmented Reality
//
//    func ar(_ arViewController: ARViewController, viewForAnnotation: ARAnnotation) -> ARAnnotationView {
//        let annotationView = AnnotationView().loadView()
//        annotationView.annotation = viewForAnnotation
//        annotationView.delegate = self
//
//        if let aPlace = viewForAnnotation as? Place {
//            annotationView.lblTitle?.text = aPlace.placeName
//            annotationView.lblDistance?.text = String(format: "%.2f km", aPlace.distanceFromUser / 1000)
//            annotationView.ratingView.rating = aPlace.rating
//            annotationView.imagePlace.layer.cornerRadius = 4
//
//            let imageUrl = URL.init(string: aPlace.imageUrl)
//            annotationView.imagePlace.sd_setImage(with: imageUrl!, placeholderImage: UIImage(named: "Placeholder"), options: .highPriority)
//        }
//
//        return annotationView
//    }
//}
//
//extension NearbyPlacesViewController: AnnotationViewDelegate {
//    func didTouch(annotationView: AnnotationView) {
//        if let annotation = annotationView.annotation as? Place {
//            self.aPlace = annotation
//        }
//
//        self.arViewController.dismiss(animated: false) {
//            self.performSegue(withIdentifier: "DirectionViewController", sender: nil)
//        }
//    }
//}
//
//// MARK: - MarkerCustomInfoDelegate Methods
//
//extension NearbyPlacesViewController: MarkerCustomInfoDelegate {
//
//    func didTouchMap() {
//        performSegue(withIdentifier: "DirectionViewController", sender: nil)
//    }
//
//}
//
//// MARK: - GMSMapViewDelegate Methods
//
//extension NearbyPlacesViewController: GMSMapViewDelegate {
//    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
//        googleMaps.isMyLocationEnabled = true
//    }
//
//    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
//        googleMaps.isMyLocationEnabled = true
//
//        if (gesture) {
//            mapView.selectedMarker = nil
//        }
//    }
//
//    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
//        tappedMarker = marker
//        googleMaps.isMyLocationEnabled = true
//
//        if let myMarker = marker as? MyMarker {
//            if let aPlace = myMarker.place {
//                displayPlaceInformationAt(marker.position, aPlace: aPlace, for: mapView)
//            }
//        }
//        return false
//    }
//
//    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
//        customInfoWindow?.removeFromSuperview()
//    }
//
//    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
//        googleMaps.isMyLocationEnabled = true
//        googleMaps.selectedMarker = nil
//        return false
//    }
//
//    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
//        return UIView()
//    }
//
//    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
//        if let aPosition = tappedMarker?.position {
//            customInfoWindow?.center = mapView.projection.point(for: aPosition)
//            customInfoWindow?.center.y -= 100
//        }
//    }
//}
//
