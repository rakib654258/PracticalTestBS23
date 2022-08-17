//
//  LoadingViewModel.swift
//  PracticalTest
//
//  Created by Softzino MBP 302 on 8/17/22.
//

import Foundation

import Foundation

class LoadingViewModel: ObservableObject {
    static var shared = LoadingViewModel()
    
    @Published var isLoading: Bool = false
    @Published var errorMessage: String = ""
    @Published var isNetworkOffLine: Bool = false
}
