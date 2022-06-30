//
//  HomeView.swift
//  ToolboxTest
//
//  Created by Tribal on 30/06/22.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewMoldel: HomeViewModel = HomeViewModel()
    var body: some View {
        ScrollView(showsIndicators: false){
            VStack{
                ForEach(viewMoldel.data, id: \.self) { carrousel in
                    CarrouselView(carrousel: carrousel)
                        .environmentObject(viewMoldel)
                }
            }
            .onAppear{
                viewMoldel.retriveData()
            }
            .shadow(color: .gray.opacity(0.5), radius: 15)
            .padding(35)
        }
        .navigationTitle("Toolbox")
        .navigationBarBackButtonHidden(true)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
