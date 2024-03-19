//
//  LocationSearchViewModel.swift
//  UberSwiftUiTutorial
//
//  Created by jackychoi on 15/10/2023.
//

import Foundation
import MapKit

class LocationSearchViewModel: NSObject, ObservableObject{
    //MARK: - Properties
    
    @Published var results = [MKLocalSearchCompletion]()
    @Published var selectLocationCoordinate: CLLocationCoordinate2D?
    private let searchCompleter = MKLocalSearchCompleter()
    var queryFragment: String = ""{
        didSet{
            searchCompleter.queryFragment = queryFragment
        }
    }
    
    override init() {
        super.init()
        searchCompleter.delegate = self
        searchCompleter.queryFragment = queryFragment
    }
//    
    //MARK: - Helper
    func selectLocaiton(_ localSearch: MKLocalSearchCompletion){
        
        locationSearch(forLocalSearchCompletion: localSearch) { response, error in
            if let error = error{
                print("error \(error.localizedDescription)")
                return
            }
            guard let item = response?.mapItems.first else{return}
            let coordinate = item.placemark.coordinate
            self.selectLocationCoordinate = coordinate
            print("DEBUG: lcoation coordinates \(coordinate)")
        }
    }
//
    func locationSearch(forLocalSearchCompletion localSearch: MKLocalSearchCompletion,
                        completion: @escaping MKLocalSearch.CompletionHandler){
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = localSearch.title.appending(localSearch.subtitle)
        let search = MKLocalSearch(request: searchRequest)
        
        search.start(completionHandler: completion)
    }
}

//MARK: - MKLocalSearchCompleterDelegate

extension LocationSearchViewModel: MKLocalSearchCompleterDelegate{
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.results = completer.results
    }
}
