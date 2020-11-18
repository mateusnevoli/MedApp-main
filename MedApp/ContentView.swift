//
//  ContentView.swift
//  MedApp
//
//  Created by mateus oliveira on 08/11/20.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseAuth
import GoogleSignIn
import UIKit


struct ContentView: View {
    @State var index = 0
    @State var visible = false
    @State var visible1 = false
    @State var alert = false
    @AppStorage("log_Status") var status = false
          @StateObject var model = ModelData()
    @StateObject var LocationModel = LocationViewModel()
          
          var body: some View {
      
              ZStack{
                  
                  if status{
                      
                      VStack(spacing: 25){
                          
                        HomeView(LocationModel: LocationModel, modell: model)
                          
                       
                      }
                  }
                  else{
                      
                    ZStack{
                LinearGradient(gradient: .init(colors: [Color("Color"),Color("Color1"),Color("Color2")]), startPoint: .top
                                            , endPoint: .bottom)
                                            .edgesIgnoringSafeArea(.all)
                                        if UIScreen.main.bounds.height > 800{
                                            SignView().navigationBarTitle("").navigationBarHidden(true)
                                        }
                                        else{
                                              ScrollView(.vertical, showsIndicators: false) {
                                                SignView()
                                             }
                                        }
                                }
                  }
              }
          }
      }
//MARK: SignView


//MARK: SignInView

//MARK: SignUp View


//MARK: ContentView_Previews
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
       Group {

        ContentView()
          .previewDevice(PreviewDevice(rawValue: "iPhone XS Max"))
               .previewDisplayName("iPhone XS Max")
   
   
        ContentView()
              .previewDevice(PreviewDevice(rawValue: "iPhone SE"))
              .previewDisplayName("iPhone SE")
        }
    }
}


 
 
