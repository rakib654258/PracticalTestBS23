//
//  ContentView.swift
//  PracticalTest
//
//  Created by Softzino MBP 302 on 8/17/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var loadingVM = LoadingViewModel.shared

    var body: some View {
        ZStack {
            MovieListVIew()

            if loadingVM.isLoading {
                ZStack {
                    Loader()
                        .zIndex(11)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black.opacity(0.65).ignoresSafeArea(.all))
            }
            if loadingVM.errorMessage != "" {
                ZStack {}.alert("Error", isPresented: .constant(true), actions: {
                    Button("Ok", role: .cancel, action: {
                        loadingVM.errorMessage = ""
                    })

                }, message: {
                    Text("\(loadingVM.errorMessage)")

                })
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
