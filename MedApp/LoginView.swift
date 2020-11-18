//
//  LoginView.swift
//  MedApp
//
//  Created by mateus oliveira on 17/11/20.
//

import SwiftUI


struct LoginView : View {
    @State var visible = false
     @ObservedObject var model : ModelData
    @State var index = 0
     
     var body: some View{
         
         ZStack{
             
            VStack{
                
                VStack{
                    
                    HStack(spacing: 15){
                        
                        Image(systemName: "envelope")
                            .foregroundColor(.black)
                        
                        TextField("Digite seu email", text: $model.email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        
                    }.padding(.vertical, 20)
                    
                    Divider()
                    
                    HStack(spacing: 15){
                        
                        Image(systemName: "lock")
                        .resizable()
                        .frame(width: 15, height: 18)
                        .foregroundColor(.black)
                        
                        
                          
                               if self.visible{
                                TextField("Digite sua senha", text: $model.password)
                        .autocapitalization(.none)
                         }
                         else{
                            SecureField("Digite sua senha", text: $model.password)
                        .autocapitalization(.none)
                        }
                        
                        Button(action: {
                             self.visible.toggle()
                        }) {
                            
                            Image(systemName: self.visible ? "eye.fill" : "eye.slash.fill")
                                .foregroundColor(.black)
                        }
                        
                    }.padding(.vertical, 20)
                
                    
                }
                .padding(.vertical)
                .padding(.horizontal, 20)
                .padding(.bottom, 30)
                .background(Color.white)
                .cornerRadius(10)
                .padding(.top, 25)
                .shadow(color: Color.black.opacity(0.5), radius: 20)
                
                
                Button(action: model.login) {
                    
                    Text("ENTRAR")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 100)
                    
                }.background(Color("Color"))
                .cornerRadius(20)
                .offset(y: -30)
                .padding(.bottom, -40)
                    .shadow(color: Color.black.opacity(0.5), radius: 20, x: 0, y: 10)
                   
                
                Button(action: model.resetPassword) {
                     Text("Esqueceu a senha?")
                         .foregroundColor(.white)
                 }
                .padding(.top, 25)
            }
             
             if model.isLoading{
                 
                 LoadingView()
             }
         }
         
         .fullScreenCover(isPresented: $model.isSignUp) {
             
            SignUpView(model: model, index: $index)
         }
         // Alerts...
         .alert(isPresented: $model.alert, content: {
             
            Alert(title: Text("Mensagem"), message: Text(model.alertMsg), dismissButton: .destructive(Text("Pronto")))
         })
     }
 }
