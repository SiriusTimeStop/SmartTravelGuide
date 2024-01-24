//
//  MapViewModel.swift
//  MapRoutes
//
//  Created by itst on 16/10/2023.
//

import SwiftUI
import MapKit
import CoreLocation

// All Map Data....

class MapViewModel: NSObject,ObservableObject,CLLocationManagerDelegate, MKMapViewDelegate{
    
    @Published var mapView = MKMapView()
    
    //Region..
    @Published var region: MKCoordinateRegion!
    
    //Map Type...
    @Published var mapType : MKMapType = .standard
    //SearchText...
    @Published var searchTxt = ""
    
    //Search Places...
    @Published var places : [Place] = []
    
    //meterPrice
    @Published var meterPrice: String?
    
    @Published var selectResult : String = ""
    
    
    var firstcoordinate = CLLocation()
    var locationSh = locationShow()
    var newAnnotation : [MKPointAnnotation] = []
    var newAnnotation2 : [MKPointAnnotation] = []
    var newAnnotation3 : [MKPointAnnotation] = []
    //updating map type...
    func updateMapType(){
        if mapType == .standard{
            mapType = .hybrid
            mapView.mapType = mapType
        }
        else{
            mapType = .standard
            mapView.mapType = mapType
        }
    }
    
    //search
    func searchQuery(){
        
        places.removeAll()
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchTxt
        
        //fetch...
        MKLocalSearch(request: request).start {(response, _) in
            guard let result = response else{ return }
            
            self.places = result.mapItems.compactMap({ (item) -> Place? in
                return Place(place: item.placemark)
            })
        }
    }
    
    // Pick Search
    func selectPlace(place: Place){
        // showing pin
        searchTxt = ""
        guard let coordinate = place.place.location?.coordinate else{return}
        
        let pointAnnotation = MKPointAnnotation()
        pointAnnotation.coordinate = coordinate
        pointAnnotation.title = place.place.name ?? "No Name"
        
        //removing all old
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotation(pointAnnotation)
        
        //Moving map to that location...
        let coordinateRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: 20000, longitudinalMeters: 20000)
        
        mapView.setRegion(coordinateRegion, animated: true)
        mapView.setVisibleMapRect(mapView.visibleMapRect, animated: true)
        
        let nycAnnotation1 = MKPointAnnotation()
        
        if (pointAnnotation.coordinate.latitude > 22.17557 && pointAnnotation.coordinate.latitude < 22.54937 && pointAnnotation.coordinate.longitude > 113.8 && pointAnnotation.coordinate.longitude < 114.4) {
            
            self.removeFlightPath()
            for x in 0...(locationSh.count()-1){
                
                let annotation = MKPointAnnotation()
                annotation.coordinate = CLLocationCoordinate2D(latitude: locationSh.latitude[0][x], longitude: locationSh.longitude[0][x])
                annotation.title = locationSh.nameForLocation[0][x]
                newAnnotation.append(annotation)
                mapView.addAnnotation(newAnnotation[x])
                mapView.delegate = self
                let req = MKDirections.Request()
                if(x == 0){
                    req.source = MKMapItem(placemark: MKPlacemark(coordinate: pointAnnotation.coordinate))
                    req.destination = MKMapItem(placemark: MKPlacemark(coordinate: newAnnotation[x].coordinate))
                }else{
                    var previous = MKPointAnnotation()
                    previous.coordinate = CLLocationCoordinate2D(latitude: locationSh.latitude[0][x-1], longitude: locationSh.longitude[0][x-1])
                    req.source = MKMapItem(placemark: MKPlacemark(coordinate: previous.coordinate))
                    req.destination = MKMapItem(placemark: MKPlacemark(coordinate: newAnnotation[x].coordinate))
                }
                
                let directions = MKDirections(request: req)
                directions.calculate { (direct,error) in
                    if error != nil{
                        print((error?.localizedDescription)!)
                        return
                    }
                    let polyline = direct?.routes.first?.polyline
                    self.mapView.addOverlay(polyline!)
                    self.mapView.setRegion(MKCoordinateRegion(polyline!.boundingMapRect), animated: true)
                    let rect = self.mapView.mapRectThatFits(polyline!.boundingMapRect,edgePadding: .init(top: 64, left: 32, bottom: 500, right: 32))
                    self.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
                }
                
                
                let annotation2 = MKPointAnnotation()
                annotation2.coordinate = CLLocationCoordinate2D(latitude: locationSh.latitude[1][x], longitude: locationSh.longitude[1][x])
                annotation2.title = locationSh.nameForLocation[1][x]
                newAnnotation2.append(annotation2)
                mapView.addAnnotation(newAnnotation2[x])
                mapView.delegate = self
                let req2 = MKDirections.Request()
                if(x == 0){
                    req2.source = MKMapItem(placemark: MKPlacemark(coordinate: pointAnnotation.coordinate))
                    req2.destination = MKMapItem(placemark: MKPlacemark(coordinate: newAnnotation2[x].coordinate))
                }else{
                    var previous = MKPointAnnotation()
                    previous.coordinate = CLLocationCoordinate2D(latitude: locationSh.latitude[1][x-1], longitude: locationSh.longitude[1][x-1])
                    req2.source = MKMapItem(placemark: MKPlacemark(coordinate: previous.coordinate))
                    req2.destination = MKMapItem(placemark: MKPlacemark(coordinate: newAnnotation2[x].coordinate))
                }
                
                let directions2 = MKDirections(request: req2)
                directions2.calculate { (direct,error) in
                    if error != nil{
                        print((error?.localizedDescription)!)
                        return
                    }
                    let polyline = direct?.routes.first?.polyline
                    self.mapView.addOverlay(polyline!)
                    self.mapView.setRegion(MKCoordinateRegion(polyline!.boundingMapRect), animated: true)
                    let rect = self.mapView.mapRectThatFits(polyline!.boundingMapRect,edgePadding: .init(top: 64, left: 32, bottom: 500, right: 32))
                    self.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
                }
                
                
                
                let annotation3 = MKPointAnnotation()
                annotation3.coordinate = CLLocationCoordinate2D(latitude: locationSh.latitude[2][x], longitude: locationSh.longitude[2][x])
                annotation3.title = locationSh.nameForLocation[2][x]
                newAnnotation3.append(annotation3)
                mapView.addAnnotation(newAnnotation3[x])
                mapView.delegate = self
                let req3 = MKDirections.Request()
                if(x == 0){
                    req3.source = MKMapItem(placemark: MKPlacemark(coordinate: pointAnnotation.coordinate))
                    req3.destination = MKMapItem(placemark: MKPlacemark(coordinate: newAnnotation3[x].coordinate))
                }else{
                    var previous = MKPointAnnotation()
                    previous.coordinate = CLLocationCoordinate2D(latitude: locationSh.latitude[2][x-1], longitude: locationSh.longitude[2][x-1])
                    req3.source = MKMapItem(placemark: MKPlacemark(coordinate: previous.coordinate))
                    req3.destination = MKMapItem(placemark: MKPlacemark(coordinate: newAnnotation3[x].coordinate))
                }
                
                let directions3 = MKDirections(request: req3)
                directions3.calculate { (direct,error) in
                    if error != nil{
                        print((error?.localizedDescription)!)
                        return
                    }
                    let polyline = direct?.routes.first?.polyline
                    self.mapView.addOverlay(polyline!)
                    self.mapView.setRegion(MKCoordinateRegion(polyline!.boundingMapRect), animated: true)
                    let rect = self.mapView.mapRectThatFits(polyline!.boundingMapRect,edgePadding: .init(top: 64, left: 32, bottom: 500, right: 32))
                    self.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
                }
            }
        }else{
        }
    }
    
    func removeFlightPath()
    {
        var overlays = mapView.overlays
        mapView.removeOverlays(overlays)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        // Error...
        print(error.localizedDescription)
    }
    
    //Getting user Region...
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else{return}
        
        self.region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 20000, longitudinalMeters: 20000)
        
        self.mapView.setRegion(self.region, animated: true)
        
        //smooth animation
        self.mapView.setVisibleMapRect(self.mapView.visibleMapRect, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let render = MKPolylineRenderer(overlay: overlay)
        render.strokeColor = .blue
        render.lineWidth = 4
        
        return render
    }
    
    func updateData(_ newData: String) {
        selectResult = newData
    }
}
