//
//  HomeView.swift
//  MedApp
//
//  Created by mateus oliveira on 09/11/20.
//

import SwiftUI
import Firebase
import MapKit
import CoreLocation

import FirebaseFirestore
import Foundation







struct HomeView: View {
 
    @State var index = 0
    @Environment (\.colorScheme) var colorScheme
    @ObservedObject var LocationModel : LocationViewModel
    @State var show = false
    @StateObject var LocationModell = LocationViewModel()
    @AppStorage("status") var logged = false
    @StateObject var model = ModelData()
    @ObservedObject var modell: ModelData
   
    
    
    var body: some View {
       
       NavigationView {
       
        if LocationModel.noLocation {
            Text("Por favor, permita acesso à localização para utilizar as funcionalidades do aplicativo")
                .foregroundColor(.black)
                .frame(width: UIScreen.main.bounds.width - 100, height: 120)
                .background(Color.white)
                .cornerRadius(10)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black.opacity(0.3).ignoresSafeArea(.all))
            
        }else{
            ZStack{
                
                // Menu...
                
                HStack{
                    
                    VStack(alignment: .leading, spacing: 12) {
                        
                      //  Image("avatar")
                        
                        Text("Olá,")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.top, 10)
                        
                        Text(modell.userName).fontWeight(.bold).font(.title).foregroundColor(.white)
                       
                        
                        VStack(alignment: .leading, spacing: 0){
                            if LocationModel.userLocation == nil{
                                HStack(spacing: 2){
                                    Image(systemName: "location.fill").resizable().frame(width: 12, height: 12).foregroundColor(.red)
                                    Text("Sem localização").font(.system(size: 15)).foregroundColor(.white)
                                }
                            }else{
                                HStack(spacing: 2){
                                    Image(systemName: "location.fill").resizable().frame(width: 12, height: 12)
                                    Text(LocationModel.userAddress).font(.system(size: 15)).frame(maxWidth: 116)
                                }.foregroundColor(.white)
                            }
                        }
                        
                        Button(action: {
                            
                            self.index = 0
                            
                            // animating Views...
                            
                            // Each Time Tab Is Clicked Menu Will be Closed...
                            withAnimation{
                                
                                self.show.toggle()
                            }
                            
                        }) {
                            
                            HStack(spacing: 25){
                                
                         //        Image("catalouge")
                         //           .foregroundColor(self.index == 0 ? Color("Color1") : Color.white)

                                
                                Text("Início")
                                .foregroundColor(self.index == 0 ? Color("Color4") : Color.white)
                            }
                            .padding(.vertical, 10)
                            .padding(.horizontal)
                            .background(self.index == 0 ? Color("Color1").opacity(0.5) : Color.clear)
                            .cornerRadius(10)
                        }
                        .padding(.top,25)
                        
                        Button(action: {
                            
                            self.index = 1
                            
                            withAnimation{
                                
                                self.show.toggle()
                            }
                            
                        }) {
                            
                            HStack(spacing: 25){
                                
                       //         Image("cart")
                        //            .foregroundColor(self.index == 1 ? Color("Color1") : Color.white)

                                
                                Text("Buscar")
                                .foregroundColor(self.index == 1 ? Color("Color4") : Color.white)
                            }
                            .padding(.vertical, 10)
                            .padding(.horizontal)
                            .background(self.index == 1 ? Color("Color1").opacity(0.5) : Color.clear)
                            .cornerRadius(10)
                        }
                        
                        Button(action: {
                            
                            self.index = 2
                            
                            withAnimation{
                                
                                self.show.toggle()
                            }
                            
                        }) {
                            
                            HStack(spacing: 25){
                                
                      //          Image("fav")
                       //             .foregroundColor(self.index == 2 ? Color("Color1") : Color.white)

                                
                                Text("Histórico")
                                .foregroundColor(self.index == 2 ? Color("Color4") : Color.white)
                            }
                            .padding(.vertical, 10)
                            .padding(.horizontal)
                            .background(self.index == 2 ? Color("Color1").opacity(0.5) : Color.clear)
                            .cornerRadius(10)
                        }
                        
                        Button(action: {
                            
                            self.index = 3
                            
                            withAnimation{
                                
                                self.show.toggle()
                            }
                            
                        }) {
                            
                            HStack(spacing: 25){
                                
                       //         Image("orders")
                       //             .foregroundColor(self.index == 3 ? Color("Color1") : Color.white)

                                
                                Text("Meus dados")
                                    .foregroundColor(self.index == 3 ? Color("Color4") : Color.white)
                            }
                            .padding(.vertical, 10)
                            .padding(.horizontal)
                            .background(self.index == 3 ? Color("Color1").opacity(0.5) : Color.clear)
                            .cornerRadius(10)
                        }
                        
                        Divider()
                            .frame(width: 150, height: 1)
                            .background(Color.white)
                            .padding(.vertical,30)
                        
                        Button(action: model.logOut) {
                            
                            HStack(spacing: 25){
                                
                                Image("out")
                                    .foregroundColor(Color.white)

                                
                                Text("Sair")
                                .foregroundColor(Color.white)
                            }
                            .padding(.vertical, 10)
                            .padding(.horizontal)
                        }
                        
                        Spacer(minLength: 0)
                    }
                    .padding(.top,25)
                    .padding(.horizontal,20)
                    
                    Spacer(minLength: 0)
                }
                .padding(.top,UIApplication.shared.windows.first?.safeAreaInsets.top)
                .padding(.bottom,UIApplication.shared.windows.first?.safeAreaInsets.bottom)
                   
              
                
                // MainView...
             
                VStack(spacing: 0){
                    
                    ZStack{
                    GeometryReader{_ in
                        
                        VStack{
                            
                            // Changing Views Based On Index...
                            
                            if self.index == 0{
                                
                                SearchView(LocationModel: LocationModel)
                            }
                            else if self.index == 1{
                                
                                CalendarView()
                            }
                            else if self.index == 2{
                                
                                CalendarView()
                            }
                            else{
                                
                                AccountView()
                            }
                        }
                    }
                    VStack{
                    HStack(spacing: 15){
                        
                        Button(action: {
                            
                            withAnimation{
                                
                                self.show.toggle()
                            }
                            
                        }) {
                            
                            // close Button...
                            HStack{
                            Image(systemName: self.show ? "xmark" : "line.horizontal.3")
                                .resizable()
                                .frame(width: self.show ? 18 : 25, height: 18)
                                .foregroundColor(Color("Color"))
                                Text(self.index == 0 ? "Início" : (self.index == 1 ? "Buscar" : (self.index == 2 ? "Histórico" : "Meus dados")))
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(Color("Color"))
                            }
                        }
                        
                        // Changing Name Based On Index...
                        
                        
                        
                        Spacer(minLength: 0)
                    }
                    .padding(.top,UIApplication.shared.windows.first?.safeAreaInsets.top)
                    .padding(.leading)
                    .padding(.top, 5)
                    
                        Spacer()
                    }
                    }
                }
                .background(Color.white)
                //Applying Corner Radius...
                .cornerRadius(self.show ? 30 : 0)
                // Shrinking And Moving View Right Side When Menu Button Is Clicked...
                .scaleEffect(self.show ? 0.9 : 1)
                .offset(x: self.show ? UIScreen.main.bounds.width / 2 : 0, y: self.show ? 15 : 0)
                // Rotating Slighlty...
                .rotationEffect(.init(degrees: self.show ? -5 : 0))
                
               
        }
            .background(Color("Color").edgesIgnoringSafeArea(.all))
            .edgesIgnoringSafeArea(.all)
            .navigationBarHidden(true)
           
       }
        
}.onAppear(perform: {
    LocationModel.locationManager.delegate = LocationModel
      })
        
}
}
