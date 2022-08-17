//
//  MovieCard.swift
//  PracticalTest
//
//  Created by Softzino MBP 302 on 8/17/22.
//

import SwiftUI

struct MovieCard: View {
    
    @State var movie: Result
    
    var body: some View {
        HStack(alignment: .center) {
            
            if let imagePath = movie.backdropPath {
                let urlStr = "https://image.tmdb.org/t/p/original\( imagePath )"
                AsyncImage(url: URL(string: urlStr)) { image in
                    image.resizable()
                        .scaledToFill()
                        .frame(width: 72, height: 120)
                        .clipped()
                } placeholder: {
                    ProgressView()
                        .frame(width: 72, height: 120, alignment: .center)
                }
            }else{
                Image("imdb")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 72, height: 120)
                    .clipped()
            }
            VStack(alignment: .leading, spacing: 8) {
                Text("\(movie.originalTitle ?? "No title")")
                    .foregroundColor(Color.black)
                    .font(.system(size: 17, weight: .medium))

                Text("\(movie.overview ?? "No Overview")")
                    .foregroundColor(Color.black)
                    .font(.system(size: 15))

            }.background(Color.white)
                .padding(.leading, 8)
        }
        Divider()
    }
}

//struct MovieCard_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieCard()
//    }
//}
