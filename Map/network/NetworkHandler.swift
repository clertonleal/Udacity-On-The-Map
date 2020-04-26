//
//  NetworkExtension.swift
//  Map
//
//  Created by Clêrton Cunha Leal on 26/04/20.
//  Copyright © 2020 Clêrton Cunha Leal. All rights reserved.
//

import Foundation

class NetworkHandler {
    func handleResponse<T: Codable>(data: Data?, response: URLResponse?, error: Error?, success: @escaping (T) -> Void, errorCallback: @escaping (NetworkError) -> Void) {
        DispatchQueue.main.async{
            if error != nil {
                errorCallback(NetworkError(status: 0, error: "Unknow Error"))
                return
            }

            if let data = data {
                let range = Range(uncheckedBounds: (5, data.count))
                let newData = data.subdata(in: range)
                print(String(data: newData, encoding: .utf8)!)


                do {
                    success(try JSONDecoder().decode(T.self, from: newData))
                } catch {
                    do {
                        let errorResponse = try JSONDecoder().decode(NetworkError.self, from: newData)
                        errorCallback(errorResponse)
                    } catch {
                        if response is HTTPURLResponse {
                            let response = (response as! HTTPURLResponse)
                            errorCallback(NetworkError(status: response.statusCode, error: "Unknow Error"))
                        } else {
                            errorCallback(NetworkError(status: 0, error: "Unknow Error"))
                        }
                    }
                }
            }
        }
    }
}
