//
//  LightViewModel.swift
//  Dorm Commands
//
//  Created by Gavin Payne on 1/17/24.
//

import Foundation
import Alamofire
import SwiftyJSON

class LightViewModel: ObservableObject{
    func lightRequest(location: String, jsonBody: Parameters) {
        AF.request(location, method: .put, parameters: jsonBody, encoding: JSONEncoding.default)
            .response { response in
                switch response.result {
                case .success:
                    print("Request successful")
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
    }
    func on(){
        lightRequest(location: "http://192.168.4.149/api/P7OayCaf4qbguP5TZtXvuhZzJatY6c59VrgJP7AM/groups/5/action", jsonBody: ["on": true] as Parameters)
    }
}
