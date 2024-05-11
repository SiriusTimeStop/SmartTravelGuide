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
    
    @State var models: [ResponseModel] = []
    
    @State var annotations: [mtrPlace] = []
    //2.
    @State private var DirectMethod: [String] = []
    @State private var DirectMethod2: [String] = []
    var body: some View {
        VStack{
            if !annotations.isEmpty {
                NewMapView(post: post, annotations: $annotations,DirectMethod: $DirectMethod,DirectMethod2: $DirectMethod2)
                    .frame(width: .infinity,height: 400)
            }else{
                Map()
                    .frame(width: .infinity,height: 400)
            }
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
                    
                    HStack{
                        Spacer()
                        Button(action: {
                            mtrAddress()
                        }, label: {
                            Text("Mtr Station")
                        })
                        Spacer()
                    }
                }
            }
        }
        .onAppear(perform: {
            // send request to server
            guard let url: URL = URL(string: "http://localhost/Public%20Transport/public_transport_api.php")
            else{
                print("invalid URL")
                return
            }
            var urlRequest: URLRequest = URLRequest(url: url)
            urlRequest.httpMethod = "GET"
            URLSession.shared.dataTask(with: urlRequest,
                                       completionHandler: {
                (data,response,error) in
                
                guard let data = data else{
                    print("invalid response")
                    return
                }
                // convert JSON response
                do{
                    self.models = try JSONDecoder().decode([ResponseModel].self,
                                                           from: data)
                }catch{
                    print(error.localizedDescription)
                }
            }).resume()
        })
        .vAlign(.top)
        .ignoresSafeArea()
    }
    func mtrAddress() {
            annotations = models.map { model in
                mtrPlace(
                    name: model.English_Name ?? "",
                    coordinate: CLLocationCoordinate2D(
                        latitude: Double(model.Lat ?? "") ?? 0.0,
                        longitude: Double(model.Lng ?? "") ?? 0.0
                    )
                )
            }
        }
}

struct mtrPlace: Identifiable{
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

//create model class
class ResponseModel: Codable,Identifiable{
    var English_Name: String? = ""
    var Lat: String? = ""
    var Lng: String? = ""
}


struct NewMapView : UIViewRepresentable{
    let post: Post
    @Binding var annotations: [mtrPlace]
    //1.
    @Binding var DirectMethod: [String]
    @Binding var DirectMethod2: [String]
    
    func makeCoordinator() -> Coordinator {
        return NewMapView.Coordinator()
    }

    func makeUIView(context: UIViewRepresentableContext<NewMapView>) -> MKMapView {
        let map = MKMapView()
        
        for annotation in annotations {
            let pin = MKPointAnnotation()
            pin.coordinate = annotation.coordinate
            pin.title = annotation.name
            pin.subtitle = "Train"
            map.addAnnotation(pin)
            
            }
        
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
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
                guard annotation is MKPointAnnotation else {
                    return nil
                }
                
                let identifier = "CustomAnnotationView"
                
                var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView
                
                if annotationView == nil {
                    annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                    if annotation.subtitle == "Train"{
                        
                        annotationView?.markerTintColor = UIColor(hex:"#FF57BFD2")
                    }else{
                        annotationView?.markerTintColor = .red
                    }
                } else {
                    annotationView?.annotation = annotation
                }
                
                return annotationView
            }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            
            let render = MKPolylineRenderer(overlay: overlay)
            render.strokeColor = .red
            render.lineWidth = 4
            return render
        }
    }
}


extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }

        return nil
    }
}
