//
//  MapTransportView.swift
//  SmartTravel
//
//  Created by jackychoi on 12/2/2024.
//

import SwiftUI
import CoreLocation
import MapKit

struct MapTransportView: View {
    let post: Post
    var body: some View {
        VStack{
            NewMapView(post: post)
                .frame(width: .infinity,height: 400)
        }
        .vAlign(.top)
    }
}


struct NewMapView : UIViewRepresentable{
    let post: Post
    
    
    func makeCoordinator() -> Coordinator {
        return NewMapView.Coordinator()
    }

    func makeUIView(context: UIViewRepresentableContext<NewMapView>) -> MKMapView {
        let map = MKMapView()
        
        let sourceCoordinate = CLLocationCoordinate2D(latitude: Double(post.locationLot1) ?? 0, longitude: Double(post.locationLon1) ?? 0)
        
        let destinationCoordinate = CLLocationCoordinate2D(latitude: Double(post.locationLot2) ?? 0, longitude: Double(post.locationLon2) ?? 0)
        
        let sourcePin = MKPointAnnotation()
        sourcePin.coordinate = sourceCoordinate
        sourcePin.title = post.location1
        map.addAnnotation(sourcePin)
        
        let destinationPin = MKPointAnnotation()
        destinationPin.coordinate = destinationCoordinate
        destinationPin.title = post.location2
        map.addAnnotation(destinationPin)
        
        let thirdCoordinate = CLLocationCoordinate2D(latitude: Double(post.locationLot3) ?? 0, longitude: Double(post.locationLon3) ?? 0)
        
        let thirdPin = MKPointAnnotation()
        thirdPin.coordinate = thirdCoordinate
        thirdPin.title = post.location3
        map.addAnnotation(thirdPin)
        
        let region = MKCoordinateRegion(center: sourceCoordinate, latitudinalMeters: 100000, longitudinalMeters: 100000)
        
        map.region = region
        map.delegate = context.coordinator
        
        let req = MKDirections.Request()
        req.source = MKMapItem(placemark: MKPlacemark(coordinate: sourceCoordinate))
        req.destination = MKMapItem(placemark: MKPlacemark(coordinate: destinationCoordinate))
        
        let directions = MKDirections(request: req)
        
        directions.calculate{ (direct,err) in
            if err != nil{
                print((err?.localizedDescription)!)
                return
            }
            
            let polyline = direct?.routes.first?.polyline
            map.addOverlay(polyline!)
//            map.setRegion(MKCoordinateRegion(polyline!.boundingMapRect), animated: true)
        }
        
        let req2 = MKDirections.Request()
        req2.source = MKMapItem(placemark: MKPlacemark(coordinate: destinationCoordinate))
        req2.destination = MKMapItem(placemark: MKPlacemark(coordinate: thirdCoordinate))
        
        let directions2 = MKDirections(request: req2)
        
        directions2.calculate{ (direct,err) in
            if err != nil{
                print((err?.localizedDescription)!)
                return
            }
            
            let polyline2 = direct?.routes.first?.polyline
            map.addOverlay(polyline2!)
            map.setRegion(MKCoordinateRegion(polyline2!.boundingMapRect), animated: true)
        }
        return map
    }
    
    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<NewMapView>) {
        
    }
    
    class Coordinator : NSObject,MKMapViewDelegate{
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            
            let render = MKPolylineRenderer(overlay: overlay)
            render.strokeColor = .systemPink
            render.lineWidth = 4
            return render
        }
    }
}
