//
//  DirectionViewController.swift
//  LBSAR
//
//  Created by skj on 10.3.2020.
//  Copyright © 2020 skj. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMaps
import MapKit
import Polyline

class DirectionViewController: UIViewController {
    @IBOutlet weak var googleMaps: GMSMapView!

    var customInfoWindow : InfoView?
    var aHomeItem = HomeItem()
    var aPlace: Place?
    var tappedMarker : GMSMarker?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // initialize info view
        customInfoWindow = InfoView().loadView()
        configureMap()
        loadDetailInformationFromGoogleAPI()
        showDirection()
    }
    
    // MARK: - Private Methods

    private func configureMap() {
        if let aPlace = aPlace {
            let camera = GMSCameraPosition.camera(withLatitude: (aPlace.location.coordinate.latitude), longitude: (aPlace.location.coordinate.longitude), zoom: 15.0)
            
            googleMaps.camera = camera
            googleMaps.delegate = self
            googleMaps?.isMyLocationEnabled = true
            googleMaps.settings.myLocationButton = true
            googleMaps.settings.compassButton = true
            googleMaps.settings.zoomGestures = true
        }
    }

    // Load data from google place detail api
    private func loadDetailInformationFromGoogleAPI() {
        if let place = aPlace {
            WebServices.loadDetailInformationFor(place) { data in
                DispatchQueue.main.sync {
                    guard let placeDetail = data else {return}
                    self.customInfoWindow?.lblPhoneNumber.text = "Phone Num: \(placeDetail.formattedPhoneNumber!)"
                    self.customInfoWindow?.lblWebsite.text = "Website: \(placeDetail.website!)"
                }
            }
        }
    }
    
    // display direction from current position to destination
    private func showDirection() {
        if let aPlace = aPlace {
            let sourceLocation = CLLocationCoordinate2D(latitude: (aPlace.curLocation?.coordinate.latitude)!, longitude: (aPlace.curLocation?.coordinate.longitude)!)
            let desLocation = CLLocationCoordinate2D(latitude: (aPlace.location.coordinate.latitude), longitude: (aPlace.location.coordinate.longitude))
            
            let sourcePlaceMark = MKPlacemark(coordinate: sourceLocation)
            let desPlaceMark = MKPlacemark(coordinate: desLocation)
            
            let source = MKMapItem(placemark: sourcePlaceMark)
            let destination = MKMapItem(placemark: desPlaceMark)
            
            let marker = MyMarker()
            let image = UIImage(named: aHomeItem.key)
            
            marker.position = CLLocationCoordinate2DMake((aPlace.location.coordinate.latitude), (aPlace.location.coordinate.longitude))
            marker.icon = image
            marker.map = self.googleMaps
            
            tappedMarker = marker
            
            displayDetailInfoDataof(aPlace, atMarker: marker)
            plotDirectionFrom(source, toDestination: destination)
        }
    }
    
    // maintain postion of info view
    private func centerInfoViewAt(position: CLLocationCoordinate2D) {
        customInfoWindow?.center = self.googleMaps.projection.point(for: position)
        customInfoWindow?.center.y -= 110
    }
    
    private func displayDetailInfoDataof(_ aPlace: Place, atMarker marker: GMSMarker) {
        centerInfoViewAt(position: marker.position)
        customInfoWindow?.lblOpen.text = aPlace.openNow ? "Open" : "Close"
        customInfoWindow?.lblTitle.text = aPlace.placeName
        self.customInfoWindow?.lblAddress.text = "Address: \(aPlace.address)"
        
        customInfoWindow?.imagePlace.setImageWith(url: URL.init(string: aPlace.imageUrl)!, placeholderImage: UIImage(named: "Placeholder")!)

        self.googleMaps.addSubview(customInfoWindow!)
    }
    
    // plot polyline path from source to destination
    private func plotDirectionFrom(_ source:MKMapItem, toDestination destination:MKMapItem) {
        let request = MKDirections.Request()
        request.source = source
        request.destination = destination
        request.requestsAlternateRoutes = false
        
        let directions = MKDirections(request: request)
        
        // get directions coordinates
        directions.calculate { (response, error) in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                let route = response?.routes[0]
                
                var coordinates = [CLLocationCoordinate2D](
                    repeating: kCLLocationCoordinate2DInvalid,
                    count: (route?.polyline.pointCount)!
                )
                
                route?.polyline.getCoordinates(
                    &coordinates,
                    range: NSRange(location: 0, length: (route?.polyline.pointCount)!))
                
                // converts the coordinates to polyline format used by Google map and draw path.
                let polyline = Polyline(coordinates: coordinates)
                let encodedPolyline: String = polyline.encodedPolyline
                let path = GMSPath(fromEncodedPath: encodedPolyline)
                
                let gmspolyline = GMSPolyline.init(path: path)
                gmspolyline.strokeWidth = 4
                gmspolyline.strokeColor = UIColor(red: 239, green: 91, blue: 48)
                gmspolyline.map = self.googleMaps
            }
        }
    }
}

// MARK: - GMSMapViewDelegate Methods

extension DirectionViewController: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        customInfoWindow?.removeFromSuperview()
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        googleMaps.isMyLocationEnabled = true
        
        // tap on marker displays info view with data
        if let aPlace = aPlace {
            displayDetailInfoDataof(aPlace, atMarker: marker)
        }
        
        return false
    }
    
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        return UIView()
    }
    
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        if let aPosition = tappedMarker?.position {
            customInfoWindow?.center = mapView.projection.point(for: aPosition)
            customInfoWindow?.center.y -= 110
        }
    }

}
