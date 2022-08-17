//
//  WebServiceHandler.swift
//  PracticalTest
//
//  Created by Softzino MBP 302 on 8/17/22.
//

import Foundation

import SwiftUI

class WebServiceHandler {
    static let shared = WebServiceHandler()
    private var loadingVM = LoadingViewModel.shared

    
    func FetchData(urlString: String, requestType: String, parameters: [String: Any]?, needBearer: Bool, completion: @escaping (Data) -> ()) {
        
        self.loadingVM.isLoading = true
        
        let url = URL(string: urlString)
        var request = URLRequest(url: url!)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        if needBearer == true {
            let defaults = UserDefaults.standard
            let token = defaults.string(forKey: Helper.constrains.accessToken)
            request.addValue("Bearer \(token ?? "nul")", forHTTPHeaderField: "Authorization")
        }
        request.httpMethod = requestType

        if parameters != nil {
            let parameters = parameters
            let jsonData = try? JSONSerialization.data(withJSONObject: parameters!)
            request.httpBody = jsonData
        }
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,
                  // check for fundamental networking error
                  let response = response as? HTTPURLResponse, error == nil
            else {
                self.loadingVM.isLoading = false
                self.loadingVM.errorMessage = error?.localizedDescription ?? "Failed to call api"
                print("Error: ", error ?? "Unknown error")
                return
            }
            guard (200 ... 299) ~= response.statusCode else {
                // check for http error
                self.loadingVM.isLoading = false
                
                switch response.statusCode {
                case 400 ... 499:
                    let yourErrorResponseString = String(data: data, encoding: .utf8)
                    print(yourErrorResponseString as Any)
                    self.loadingVM.isLoading = false
                case 500 ... 599:
                    let yourErrorResponseString = String(data: data, encoding: .utf8)
                    print(yourErrorResponseString as Any)
                    self.loadingVM.isLoading = false
                default:
                    break
                }
                print("status code shuld be 2xx, but is \(response.statusCode), \(response)")
                print("Error: \(String(describing: response.suggestedFilename))")
                return
            }
            DispatchQueue.main.async {
                self.loadingVM.isLoading = false
                completion(data)
            }
        }
        task.resume()
    }
}

//enum RequestType: String {
//    case get = "GET"
//    case post = "POST"
//    case delete = "DELETE"
//    case put = "PUT"
//}
