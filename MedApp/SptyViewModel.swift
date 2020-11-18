//
//  AllViewModel.swift
//  MedApp
//
//  Created by mateus oliveira on 09/11/20.
//

import SwiftUI
import Firebase
import CoreLocation
import FirebaseFirestore
import Foundation

struct Spty: Identifiable{
    var id: String = UUID().uuidString
    var spty: String
   
}

class SptyViewModel: NSObject, ObservableObject{
    
  
    @Published var specialities = [Spty]()
    
    func fetchData(){
        let db = Firestore.firestore()
        db.collection("specialities").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {return }
            self.specialities = documents.map { (queryDocumentSnapshot) -> Spty in
               let data = queryDocumentSnapshot.data()
                
                let spty = data["spty"] as? String ?? ""
                
                return Spty(spty: spty)
            }
        }
        
    //  idea opn how to connect user location and doctor spty ->  db.collection("doctors").whereField("location", isEqualTo: "Feira de Santana").whereField("spty", isEqualTo: "Cardiologista").getDocuments { (snap, err) in
     //       <#code#>
      //  }
    }

}


