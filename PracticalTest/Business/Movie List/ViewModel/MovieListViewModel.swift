//
//  MovieListViewModel.swift
//  PracticalTest
//
//  Created by Softzino MBP 302 on 8/17/22.
//

import Foundation

class MovieListViewModel: ObservableObject {
    @Published var movieList: [Result] = []
    
    // for image https://image.tmdb.org/t/p/original
    
    @Published var message = ""
    @Published var isLoading = false

    @Published var title = ""
    @Published var isShowAlert = false
    
    init() {
        getMovieList()
    }
    
    func getMovieList() {
        let requestType = "GET"
        let url = "https://api.themoviedb.org/3/search/movie?api_key=fe2dcf4dc1dc9e9b44da556cad0d9aac&query=marvel"
        
        WebServiceHandler.shared.FetchData(urlString: url, requestType: requestType, parameters: nil, needBearer: false) { data in
            do {
                let jsonData = try JSONDecoder().decode(MovieList.self, from: data)
                print(jsonData)
                if jsonData.results != nil {
                    DispatchQueue.main.async {
                        self.movieList = jsonData.results ?? []
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
