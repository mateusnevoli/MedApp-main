//
//  SignView.swift
//  MedApp
//
//  Created by mateus oliveira on 17/11/20.
//

import SwiftUI
import GoogleSignIn

struct SignView: View {
    @State var index = 0
    @State var visible = false
    @State var visible1 = false
    @State var alert = false
    @StateObject var model = ModelData()

    
    
    var body: some View{
       
        VStack{
                    Image("floco")
                    .resizable()
                    .frame(width: 180, height: 180)
                HStack{
                                
                                Button(action: {
                                    
                                    withAnimation(.spring(response: 0.4, dampingFraction: 0.8, blendDuration: 0.8)){
                                        
                                        self.index = 0
                                    }
                                    
                                }) {
                                    
                                    Text("Entrar")
                                        .foregroundColor(self.index == 0 ? .white : .white)
                                        .fontWeight(.bold)
                                        .padding(.vertical, 10)
                                        .frame(width: (UIScreen.main.bounds.width - 50) / 2)
                                    
                                }.background(self.index == 0 ? Color("Color") : Color.clear)
                                .clipShape(Capsule())
                               
                                
                                Button(action: {
                                    
                                    withAnimation(.spring(response: 0.4, dampingFraction: 0.8, blendDuration: 0.8)){
                                        
                                        self.index = 1
                                    }
                                    
                                }) {
                                    
                                    Text("Cadastrar-se")
                                        .foregroundColor(self.index == 1 ? .white : .white)
                                        .fontWeight(.bold)
                                        .padding(.vertical, 10)
                                        .frame(width: (UIScreen.main.bounds.width - 50) / 2)
                                    
                                    
                                }.background(self.index == 1 ? Color("Color") : Color.clear)
                                .clipShape(Capsule())
                                
                                
                            }.background(Color.white.opacity(0.1))
                                    .clipShape(Capsule())
                            .padding(.top, 25)
                    .shadow(color: Color.black.opacity(0.5), radius: 20)
            
                            
                           
                        
                        if self.index == 0{
                            LoginView(model: model).navigationTitle("").navigationBarHidden(true)
                        }
                        else{
                            SignUpView(model: model, index: $index).navigationTitle("").navigationBarHidden(true)
                        }
                        
                        HStack(spacing: 15){
                            
                            Color.white.opacity(0.7)
                            .frame(width: 35, height: 1)
                            
                            Text("OU")
                                .bold()
                                .foregroundColor(.white)
                         
                            Color.white.opacity(0.7)
                            .frame(width: 35, height: 1)
                            
                        }
                        
                        
                     HStack{
                            
                        Button(action: {
                            
                            //LoginIn user
                            GIDSignIn.sharedInstance()?.presentingViewController = UIApplication.shared.windows.first?.rootViewController
                            GIDSignIn.sharedInstance()?.signIn()
                             
                        }){
                            Image("google1")
                                .renderingMode(.original)
                                .resizable()
                                .frame(width: 35, height: 35)
                                .padding(.all, 3)
                               }
                            }
                        
                    } .padding()
    }
    }
