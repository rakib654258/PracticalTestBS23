//
//  MovieListVIew.swift
//  PracticalTest
//
//  Created by Softzino MBP 302 on 8/17/22.
//

import SwiftUI

struct MovieListVIew: View {
    @StateObject var vm = MovieListViewModel()
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading) {
                    Divider()
                    ForEach(filterMovieList) { movie in
                        MovieCard(movie: movie)
                    }
                }
                .searchable(text: $searchText)
                .navigationTitle("Movie List")
                .padding()
            }
        }
    }
    
    // filter movie list data
    var filterMovieList: [Result] {
        if searchText.isEmpty {
            return vm.movieList
        } else {
            return vm.movieList.filter { ($0.originalTitle ?? "").contains(searchText) }
        }
    }
}

struct MovieListVIew_Previews: PreviewProvider {
    static var previews: some View {
        MovieListVIew()
    }
}
