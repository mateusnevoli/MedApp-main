//
//  SessionStore.swift
//  MedApp
//
//  Created by mateus oliveira on 14/11/20.
//

import SwiftUI
import Firebase
import GoogleSignIn
import Combine
import FirebaseCore
import UIKit
import LocalAuthentication


class ModelData : ObservableObject {
      
      @Published var email = ""
      @Published var password = ""
      @Published var isSignUp = false
      @Published var email_SignUp = ""
      @Published var password_SignUp = ""
      @Published var reEnterPassword = ""
      @Published var isLinkSend = false
      @Published var alert = false
      @Published var alertMsg = ""
      @AppStorage("log_Status") var status = false
      @Published var isLoading = false
      @Published var userName = ""
      
      func resetPassword(){
          
          let alert = UIAlertController(title: "Redefinir a senha", message: "Digite seu email para redefinir a senha", preferredStyle: .alert)
          
          alert.addTextField { (password) in
              password.placeholder = "Digite seu email"
          }
          
          let proceed = UIAlertAction(title: "Redefinir", style: .default) { (_) in
              
              // Sending Password Link...
              
              if alert.textFields![0].text! != ""{
                  
                  withAnimation{
                      
                      self.isLoading.toggle()
                  }
                  
                  Auth.auth().sendPasswordReset(withEmail: alert.textFields![0].text!) { (err) in
                      
                      withAnimation{
                          
                          self.isLoading.toggle()
                      }
                      
                      if err != nil{
                          self.alertMsg = err!.localizedDescription
                          self.alert.toggle()
                          return
                      }
                      
                      // ALerting User...
                      self.alertMsg = "Link de redefinição foi enviado ao seu email"
                      self.alert.toggle()
                  }
              }
          }
          
          let cancel = UIAlertAction(title: "Cancelar", style: .destructive, handler: nil)
          
          alert.addAction(cancel)
          alert.addAction(proceed)
          
          // Presenting...
          
          UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true)
      }
      
      // Login...
      
      func login(){
          
          // checking all fields are inputted correctly...
          
          if email == "" || password == ""{
              
              self.alertMsg = "Preencha todos os espaços adequadamente"
              self.alert.toggle()
              return
          }
          
          withAnimation{
              
              self.isLoading.toggle()
          }
          
          Auth.auth().signIn(withEmail: email, password: password) { (result, err) in
              
              withAnimation{
                  
                  self.isLoading.toggle()
              }
              
              if err != nil{
                  
                  self.alertMsg = "Usuário não existe ou senha e/ou email incorretos"
                  self.alert.toggle()
                  return
              }
              
              // checking if user is verifed or not...
              // if not verified means lgging out...
              
              let user = Auth.auth().currentUser
              
              if !user!.isEmailVerified{
                  
                  self.alertMsg = "Por favor, verifique seu endereço de email"
                  self.alert.toggle()
                  try! Auth.auth().signOut()
                  
                  return
              }
              
              // setting user status as true....
              
              withAnimation{
                  
                  self.status = true
              }
          }
      }
      
      // SignUp..
      
      func signUp(){
          
          // checking....
          
          if email_SignUp == "" || password_SignUp == "" || reEnterPassword == "" || userName == ""{
              
              self.alertMsg = "Preencha todos os espaços adequadamente"
              self.alert.toggle()
              return
          }
          
          if password_SignUp != reEnterPassword{
              
              self.alertMsg = "Senhas não combinam"
              self.alert.toggle()
              return
          }
          
          withAnimation{
              
              self.isLoading.toggle()
          }
          
        Auth.auth().createUser(withEmail: email_SignUp, password: password_SignUp) {   (result, err) in
              
              withAnimation{
                  
                  self.isLoading.toggle()
              }
              
              if err != nil{
                  self.alertMsg = "Usuário já exitse, email mal formatado e/ou a senha precisa ter 6 caracteres ou mais"
                  self.alert.toggle()
                  return
              }
            let db = Firestore.firestore()
               
            db.collection("PROFILE").document(result!.user.uid).setData(["userName" : self.userName])
               
              // sending Verifcation Link....
              
              result?.user.sendEmailVerification(completion: { (err) in
                  
                  if err != nil{
                      self.alertMsg = err!.localizedDescription
                      self.alert.toggle()
                      return
                  }
                  
                  // Alerting User To Verify Email...
                  
                  self.alertMsg = "A verificação de email foi enviada, verifique seu email"
                  self.alert.toggle()
              })
          }
      }
      
      // log Out...
      
      func logOut(){
          
          try! Auth.auth().signOut()
          
          withAnimation{
              
              self.status = false
          }
          
          // clearing all data...
          
          email = ""
          password = ""
          email_SignUp = ""
          password_SignUp = ""
          reEnterPassword = ""
      }
      
  }
  
  // Checking With Smaller Devices....
  
  
  // Loading View...
  
  struct LoadingView : View {
      
      @State var animation = false
      
      var body: some View{
          
          VStack{
              
              Circle()
                  .trim(from: 0, to: 0.7)
                  .stroke(Color("Color1"),lineWidth: 8)
                  .frame(width: 75, height: 75)
                  .rotationEffect(.init(degrees: animation ? 360 : 0))
                  .padding(50)
          }
          .background(Color.clear)
          .cornerRadius(20)
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .background(Color.clear.ignoresSafeArea(.all, edges: .all))
          .onAppear(perform: {
              
              withAnimation(Animation.linear(duration: 1)){
                  
                  animation.toggle()
              }
          })
      }
  }
