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
    var directionDependency: DirectionDependency?
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
        if let dependency = directionDependency {
            let latitude = CLLocationDegrees((dependency.place?.geometry?.location?.lat)!)
            let longitude = CLLocationDegrees((dependency.place?.geometry?.location?.lng)!)

            let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 15.0)
            
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
        guard let place = directionDependency?.place else { return }
        WebServices.loadDetailInformationFor(place) { data in
            DispatchQueue.main.sync {
                guard let placeDetail = data else {return}
                self.customInfoWindow?.lblPhoneNumber.text = "Phone Num: \(placeDetail.formattedPhoneNumber!)"
                self.customInfoWindow?.lblWebsite.text = "Website: \(placeDetail.website!)"
            }
        }
    }
    
    // display direction from current position to destination
    private func showDirection() {
        guard let directionDetail = directionDependency else {return}
        if let aPlace = directionDetail.place {
            let srcLatitude = CLLocationDegrees((directionDetail.currentLocation?.coordinate.latitude)!)
            let srcLongitude = CLLocationDegrees((directionDetail.currentLocation?.coordinate.longitude)!)
            let desLatitude = CLLocationDegrees((aPlace.geometry?.location?.lat)!)
            let desLongitude = CLLocationDegrees((aPlace.geometry?.location?.lng)!)
            
            let sourceLocation = CLLocationCoordinate2D(latitude: srcLatitude, longitude: srcLongitude)
            let desLocation = CLLocationCoordinate2D(latitude: desLatitude, longitude: desLongitude)
            
            let sourcePlaceMark = MKPlacemark(coordinate: sourceLocation)
            let desPlaceMark = MKPlacemark(coordinate: desLocation)
            
            let source = MKMapItem(placemark: sourcePlaceMark)
            let destination = MKMapItem(placemark: desPlaceMark)
            
            let marker = MyMarker()
            let image = UIImage(named: directionDetail.home!.key)
            
            marker.position = CLLocationCoordinate2DMake(desLatitude, desLongitude)
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
    
    private func displayDetailInfoDataof(_ aPlace: Results, atMarker marker: GMSMarker) {
        centerInfoViewAt(position: marker.position)
        if let openNow = aPlace.openingHours?.openNow {
            customInfoWindow?.lblOpen.text = openNow ? "Open" : "Close"
        }

        customInfoWindow?.lblTitle.text = aPlace.name
        self.customInfoWindow?.lblAddress.text = "Address: \(aPlace.vicinity!)"

//        let imageUrl = URL.init(string: aPlace.imageUrl)

//        customInfoWindow?.imagePlace.sd_setImage(with: imageUrl!, placeholderImage: UIImage(named: "Placeholder"), options: .highPriority)
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
        if let aPlace = directionDependency?.place {
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
