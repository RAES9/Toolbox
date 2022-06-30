//
//  LoginView.swift
//  ToolboxTest
//
//  Created by Tribal on 30/06/22.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel: LoginViewModel = LoginViewModel()
    var body: some View {
        NavigationView{
            ZStack{
                NavigationLink(isActive: $viewModel.navigateToHome) {
                    HomeView()
                } label: {
                    EmptyView()
                }
                VStack{
                    Text("Test Esteban Toolbox")
                        .padding(30)
                        .font(.headline)
                    Button {
                        viewModel.doLogin()
                    } label: {
                        Text("Login")
                            .foregroundColor(.white)
                            .bold()
                            .frame(maxWidth: .infinity, maxHeight: 40)
                            .background(
                                Color.cyan
                                    .cornerRadius(15)
                            )
                    }
                }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
