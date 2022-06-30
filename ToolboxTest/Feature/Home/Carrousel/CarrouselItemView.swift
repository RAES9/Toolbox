//
//  CarrouselItemView.swift
//  ToolboxTest
//
//  Created by Tribal on 30/06/22.
//

import SwiftUI
import AVKit

struct CarrouselItemView: View {
    var image: String
    var title: String
    var video: String?
    var description: String
    @EnvironmentObject var viewModel: HomeViewModel
    var body: some View {
        VStack{
            AsyncImage(
                url: URL(string: image),
                content: { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }, placeholder: {
                    Color.gray
                }
            )
            .clipShape(RoundedRectangle(cornerRadius: 25))
            Text(title)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title2)
            Text(description)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.caption)
            if let url = video {
                Button {
                    viewModel.player = AVPlayer(url: URL(string: url)!)
                    viewModel.showVideo = true
                } label: {
                    Text("Preview")
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
        .frame(maxHeight: .infinity, alignment: .top)
        .padding(35)
        .sheet(isPresented: $viewModel.showVideo) {
            VideoPlayer(player: viewModel.player)
                .onAppear{
                    viewModel.player.play()
                }
                .onDisappear{
                    viewModel.player.pause()
                }
                .ignoresSafeArea()
        }
    }
}

struct CarrouselItemView_Previews: PreviewProvider {
    static var previews: some View {
        CarrouselItemView(image: "http://placeimg.com/640/480/any", title: "Movie 1", video: "https://d11gqohmu80ljn.cloudfront.net/128/media-20210712191955-cbdi-0.m3u8/master.m3u8", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
            .environmentObject(HomeViewModel())
    }
}
