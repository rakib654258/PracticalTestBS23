//
//  LoadingView.swift
//  PracticalTest
//
//  Created by Softzino MBP 302 on 8/17/22.
//

import Foundation
import SwiftUI

struct Loader: View{
    @State var animate: Bool = true
    
    var body: some View{
        GeometryReader{ reader in
            VStack{
                Circle()
                    .trim(from: 0, to: 0.8)
                    .stroke(AngularGradient(gradient: .init(colors: [Color.red, Color.orange]), center: .center), style: StrokeStyle(lineWidth: 8, lineCap: .round))
                    .frame(width: 45, height: 45)
                    .rotationEffect(.init(degrees: self.animate ? 360 : 0))
                    .animation(Animation.linear(duration: 0.7).repeatForever(autoreverses: false), value: animate)
                Text("Please wait..")
                    .foregroundColor(Color.black)
                    .padding(.top)
            }
            .padding(20)
            .background(Color.white)
            .cornerRadius(15)
            .frame(width: reader.size.width, height: reader.size.height, alignment: .center)
            .onAppear{
                self.animate.toggle()
            }
        }
    }
}
