//
//  InfoViewModel.swift
//  MedApp
//
//  Created by mateus oliveira on 14/11/20.
//
import SwiftUI
import Firebase
import CoreLocation
import FirebaseFirestore
import Foundation

struct Info: Identifiable{
    var id: String = UUID().uuidString
    var title: String
    var subtitle: String
}



class InfoViewModel: NSObject, ObservableObject {
    @Published var infos = [Info]()
    func fetchData1(){
        let ref = Firestore.firestore()
        ref.collection("infos").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {return}
            self.infos = documents.map { (queryDocumentSnapshot) -> Info in
                let data = queryDocumentSnapshot.data()
                
                let title = data["title"] as? String ?? ""
                let subtitle = data["subtitle"] as? String ?? ""
                
                return Info(title: title, subtitle: subtitle)
            }
        }
    }
    
    
    
}

