//
//  SearchView.swift
//  MedApp
//
//  Created by mateus oliveira on 09/11/20.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import Foundation
import CoreLocation




struct SearchView: View {
    @ObservedObject var LocationModel : LocationViewModel
    @StateObject var sptyModel = SptyViewModel()
    @StateObject var infoModel = InfoViewModel()
  
    
    
    
      var body: some View {
        ScrollView(.vertical, showsIndicators: false){
        VStack{
            ScrollView(.vertical,showsIndicators: false) {
                VStack(spacing: 0){
              
                         ScrollView(.horizontal, showsIndicators: false){
                            HStack(spacing: 15){
                                ForEach(infoModel.infos){ info in
                                HStack(spacing: 20){
                                Text(info.title)
                                .frame(height: 220)
                                .frame(width: 330)
                                    .background(Color.yellow)
                               .cornerRadius(18)
                                }
                            }
                                                   
                            }.padding(.horizontal, 15)
                            .padding(.bottom, 25)
                         }
                
                Spacer()
                    ForEach(sptyModel.specialities){ spty in
                        NavigationLink(destination: More()) {
                           
                          
                                HStack{
                                    
                        Text(spty.spty).foregroundColor(.black)
                           
                                }
                                .frame(width: UIScreen.main.bounds.width - 30)
                          .frame(height: 105)
                                .background(Color.blue)
                          .cornerRadius(38)
                                
                         //   .padding(.horizontal)
                                .padding(.bottom, 20)
                              
                        }
                    }
                }.navigationBarTitle("")
                .navigationBarHidden(true)
            }
        }.padding(.top,UIApplication.shared.windows.first?.safeAreaInsets.top)
        }.onAppear(){
            self.sptyModel.fetchData()
            self.infoModel.fetchData1()
        }
}
}
        
struct More: View{
    var body: some View{
        Text("hello")
    }
}


