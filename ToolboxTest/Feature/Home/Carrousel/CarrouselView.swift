//
//  CarrouselView.swift
//  ToolboxTest
//
//  Created by Tribal on 30/06/22.
//

import SwiftUI

struct CarrouselView: View {
    var carrousel: Carrousel
    @EnvironmentObject var viewModel: HomeViewModel
    var body: some View {
        VStack{
            Text(carrousel.title)
                .bold()
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(carrousel.type)
                .font(.title3)
                .frame(maxWidth: .infinity, alignment: .leading)
            ScrollView(.horizontal, showsIndicators: false){
                HStack{
                    ForEach(carrousel.items, id: \.self) { item in
                        CarrouselItemView(image: item.imageUrl, title: item.title, video: item.videoUrl, description: item.description)
                            .frame(width: 300)
                            .environmentObject(viewModel)
                    }
                }
            }
        }
    }
}

struct CarrouselView_Previews: PreviewProvider {
    static var previews: some View {
        CarrouselView(carrousel: Carrousel(title: "", type: "", items: []))
            .environmentObject(HomeViewModel())
    }
}
