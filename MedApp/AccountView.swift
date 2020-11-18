//
//  AccountView.swift
//  MedApp
//
//  Created by mateus oliveira on 09/11/20.
//

import SwiftUI
import Firebase

struct AccountView: View {
    @StateObject var model = ModelData()
    var body: some View {
        NavigationView {
            VStack(spacing:0){
                NavigationLink(destination: Wes()){
                    
                
                    Text("perfil")
                    .font(.system(size: 40))
                }
                
                
                Spacer()
                
                Button(action: {}) {
                    Text("sair")
                        .font(.system(size: 40)).foregroundColor(.black)
                }
              
                
            }
        }.edgesIgnoringSafeArea(.all)

}
}
struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}

struct Wes: View{
    var body: some View{
        Text("teste")
    }
}




