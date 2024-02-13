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
    
    //2.
    @State private var DirectMethod: [String] = []
    @State private var DirectMethod2: [String] = []
    var body: some View {
        VStack{
            NewMapView(post: post,DirectMethod: $DirectMethod,DirectMethod2: $DirectMethod2)
                .frame(width: .infinity,height: 400)
            
            VStack{
                Text("Directions")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                
                Divider().background(Color.blue)
                
                List{
                    Text(post.location1)
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                    ForEach(0..<self.DirectMethod.count,id: \.self){i in
                        Text(self.DirectMethod[i])
                            .padding()
                    }
                    Text(post.location2)
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                    ForEach(0..<self.DirectMethod2.count,id: \.self){i in
                        Text(self.DirectMethod2[i])
                            .padding()
                    }
                    Text(post.location3)
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                }
            }
            .padding(.bottom,130)
        }
        .vAlign(.top)
        .ignoresSafeArea()
    }
}


struct NewMapView : UIViewRepresentable{
    let post: Post
    
    //1.
    @Binding var DirectMethod: [String]
    @Binding var DirectMethod2: [String]
    
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
        req.transportType = .automobile
        let directions = MKDirections(request: req)
        
        directions.calculate{ (direct,err) in
            if err != nil{
                print((err?.localizedDescription)!)
                return
            }
            guard let route = direct?.routes.first else{ return }
            let polyline = direct?.routes.first?.polyline
            map.addOverlay(polyline!)
//            map.setRegion(MKCoordinateRegion(polyline!.boundingMapRect), animated: true)
            //3.
            self.DirectMethod = route.steps.map{$0.instructions}.filter{!$0.isEmpty}
        }
        
        let req2 = MKDirections.Request()
        req2.source = MKMapItem(placemark: MKPlacemark(coordinate: destinationCoordinate))
        req2.destination = MKMapItem(placemark: MKPlacemark(coordinate: thirdCoordinate))
        req2.transportType = .automobile
        
        let directions2 = MKDirections(request: req2)
        
        directions2.calculate{ (direct,err) in
            if err != nil{
                print((err?.localizedDescription)!)
                return
            }
            guard let route2 = direct?.routes.first else{ return }
            let polyline2 = direct?.routes.first?.polyline
            map.addOverlay(polyline2!)
            map.setRegion(MKCoordinateRegion(polyline2!.boundingMapRect), animated: true)
            map.setVisibleMapRect(polyline2!.boundingMapRect, edgePadding: UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50), animated: true)
            //3.
            self.DirectMethod2 = route2.steps.map{$0.instructions}.filter{!$0.isEmpty}
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
