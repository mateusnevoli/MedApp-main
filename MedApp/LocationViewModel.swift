//
//  HomeViewModel.swift
//  MedApp
//
//  Created by mateus oliveira on 14/11/20.
//

import SwiftUI
import Firebase
import CoreLocation
import FirebaseFirestore
import Foundation


class LocationViewModel: NSObject, ObservableObject, CLLocationManagerDelegate{
    @Published var locationManager = CLLocationManager()
    @Published var userLocation : CLLocation!
    @Published var userAddress = ""
    @Published var noLocation = false
    
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse:
            self.noLocation = false
            manager.requestLocation()
        case .denied:
            self.noLocation = true
        default:
            self.noLocation = false
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.userLocation = locations.last
        self.extractLocation()
    }
    
    func extractLocation(){
        CLGeocoder().reverseGeocodeLocation(self.userLocation) { (res, err) in
            guard let safeData = res else {return}
            
            var address = ""
            
         //   address += safeData.first?.name ?? ""
         //   address += ", "
            address += safeData.first?.locality ?? ""
            
            
            self.userAddress = address
       print(address)
        }
    }
     
    
}
