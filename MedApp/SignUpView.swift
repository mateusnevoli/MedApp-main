//
//  SignUpView.swift
//  MedApp
//
//  Created by mateus oliveira on 17/11/20.
//

import SwiftUI

struct SignUpView : View {
    
    @ObservedObject var model : ModelData
   @State var visible = false
   @State var visible1 = false
    @Binding var index: Int
    var body: some View{
        
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top), content: {
            
            VStack{
               
               VStack{
                   
                   HStack(spacing: 15){
                       
                       Image(systemName: "envelope")
                           .foregroundColor(.black)
                       
                       TextField("Digite seu email", text: $model.email_SignUp)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                       
                   }.padding(.vertical, 20)
                   
                   Divider()
                HStack(spacing: 15){
                    
                    Image(systemName: "person")
                        .foregroundColor(.black)
                    TextField("Digite seu nome", text: $model.userName)
                           .keyboardType(.phonePad)
                          .autocapitalization(.none)
        
                    
                }.padding(.vertical, 20)
                
                Divider()
                   
                   HStack(spacing: 15){
                       
                       Image(systemName: "lock")
                       .resizable()
                       .frame(width: 15, height: 18)
                       .foregroundColor(.black)
                       
                    if self.visible{
                       TextField("Digite uma senha", text:$model.password_SignUp)
                            .autocapitalization(.none)
                    }
                    else{
                       SecureField("Digite uma senha", text: $model.password_SignUp)
                            .autocapitalization(.none)
                    }
                       Button(action: {
                        self.visible.toggle()
                       }) {
                           
                            Image(systemName: self.visible ? "eye.fill" : "eye.slash.fill")
                               .foregroundColor(.black)
                       }
                       
                   }.padding(.vertical, 20)
                
               
                   
                   Divider()
                   
                   HStack(spacing: 15){
                       
                       Image(systemName: "lock")
                       .resizable()
                       .frame(width: 15, height: 18)
                       .foregroundColor(.black)
                       
                     if self.visible1{
                       TextField("Digite novamente", text: $model.reEnterPassword)
                             .autocapitalization(.none)
                     }
                     else{
                       SecureField("Digite novamente", text: $model.reEnterPassword)
                             .autocapitalization(.none)
                     }
                        Button(action: {
                         self.visible1.toggle()
                        }) {
                            
                             Image(systemName: self.visible1 ? "eye.fill" : "eye.slash.fill")
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
               
               
               Button(action: model.signUp) {
                   
                   Text("CRIAR CONTA")
                       .foregroundColor(.white)
                       .fontWeight(.bold)
                       .padding(.vertical)
                       .frame(width: UIScreen.main.bounds.width - 100)
                   
               }.background(Color("Color"))
               .cornerRadius(20)
               .offset(y: -40)
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
        })
        
        // Alerts...
        .alert(isPresented: $model.alert, content: {
            
            Alert(title: Text("Mensagem"), message: Text(model.alertMsg), dismissButton: .destructive(Text("pronto"), action: {
                 
                // if email link sent means closing the signupView....
                
                if model.alertMsg == "A verificação de email foi enviada, verifique seu email"{
                    
                    
                    model.email_SignUp = ""
                    model.userName = ""
                    model.password_SignUp = ""
                    model.reEnterPassword = ""
                    withAnimation(Animation.linear(duration: 0.4)){
                        
                        self.index = 0
                    }
                }
                
            }))
        })
    }
}
