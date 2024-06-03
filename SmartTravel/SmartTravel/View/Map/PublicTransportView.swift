//
//  PublicTransportView.swift
//  SmartTravel
//
//  Created by jackychoi on 11/5/2024.
//

import SwiftUI
import MapKit
import CoreLocation



struct PublicTransportView: View {
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 22.3700556 , longitude: 114.1535941), latitudinalMeters: 3000, longitudinalMeters: 3000)
    
    @State var models: [ResponseModel] = []
    @State var annotations: [mtrPlace] = []
    @StateObject private var viewModel = LocationGpsViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(alignment:.leading){
            Button {
                mtrAddress()
            } label: {
                HStack{
                    Image("HK_MTR_logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: UIScreen.main.bounds.width * 0.04, maxHeight: UIScreen.main.bounds.height * 0.04)
                    
                    Text("MTR")
                        .padding(.leading,5)
                }
            }
            .padding(.leading,10)
            Map(coordinateRegion: $viewModel.region,showsUserLocation: true,annotationItems: annotations){
                annotation in
                MapAnnotation(coordinate: annotation.coordinate) {
                    HStack{
                        Image("HK_MTR_logo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: UIScreen.main.bounds.width * 0.04, maxHeight: UIScreen.main.bounds.height * 0.04)
                        Text(annotation.name)
                            .font(.caption2)
                            .fontWeight(.semibold)
                    }.padding(5)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                }
            }
            .onAppear{
                viewModel.checkIfLocationServicesIsEnabled()
            }
            .ignoresSafeArea()
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

#Preview {
    PublicTransportView()
}

final class LocationGpsViewModel: NSObject,ObservableObject,CLLocationManagerDelegate{
    var locationManagers: CLLocationManager?
    
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 22.32538, longitude: 114.18028), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    
    func checkIfLocationServicesIsEnabled(){
        if CLLocationManager.locationServicesEnabled(){
            locationManagers = CLLocationManager()
            locationManagers!.delegate = self
            
        }else{
            print("Show a alert")
        }
    }
    
   private func checkLocationAuthorization(){
        guard let locationManagers = locationManagers else{return}
        
        switch locationManagers.authorizationStatus{
        
        case .notDetermined:
            locationManagers.requestWhenInUseAuthorization()
        case .restricted:
            print("Your location is restricted likely due to parental controls.")
        case .denied:
            print("You have denied this app location permission. Go into settings to change it")
        case .authorizedAlways,.authorizedWhenInUse:
            region = MKCoordinateRegion(center: locationManagers.location!.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.08, longitudeDelta: 0.08))
        @unknown default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
}
