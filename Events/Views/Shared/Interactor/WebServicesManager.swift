//
//  WebServicesManager.swift
//  Events
//
//  Created by Luntu on 2020/07/27.
//  Copyright © 2020 Luntu. All rights reserved.
//

import Foundation

typealias BoundarySuccessBlock = (_ payData: [String: Any]) -> Void
typealias BoundarySuccessBlockImage = (_ imageData: Data) -> Void
typealias BoundaryFailureBlock = (_ error: Error) -> Void

class WebServicesManager {
    
    private static let ApiKey = "M1ZlbnQ2LU1AbmFnM3InUHVibCFjLUszeS1GMHIrVGgzbV80bkRyMCFEJ0IhMGI="
    private static let AppId = "e2f83553-4cea-4f02-9e04-1763901ef7f0"
    
    func post(with httpRequestBody: String,
              successBlock success: @escaping BoundarySuccessBlock,
              failureBlock failure: @escaping BoundaryFailureBlock) {
        let url = URL(string: "https://oldmutual-test.survey.co.za/EventsQA/api/AppEvent/\(httpRequestBody)")!
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue(WebServicesManager.ApiKey, forHTTPHeaderField: "ApiKey")
        urlRequest.addValue(WebServicesManager.AppId, forHTTPHeaderField: "AppId")
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest) { (data, urlResponse, error) in
            if let httpResponse = urlResponse as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    if let responseData = data {
                        do {
                            let json = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: Any]
                            if let payData = json {
                                success(payData)
                            } else {
                                failure(self.createGenericError())
                            }
                        } catch {
                            failure(error)
                        }
                    } else {
                        failure(error ?? self.createGenericError())
                    }
                }
            } else {
                failure(error ?? self.createGenericError())
            }
        }
        task.resume()
    }
    
    func post(withImageURL url: String,
              successBlock success: @escaping BoundarySuccessBlockImage,
              failureBlock failure: @escaping BoundaryFailureBlock) {
        let url = URL(string: url)!
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue(WebServicesManager.ApiKey, forHTTPHeaderField: "ApiKey")
        urlRequest.addValue(WebServicesManager.AppId, forHTTPHeaderField: "AppId")
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest) { (data, urlResponse, error) in
            if let httpResponse = urlResponse as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    if let responseData = data {
                        success(responseData)
                    } else {
                        failure(error ?? self.createGenericError())
                    }
                }
            } else {
                failure(error ?? self.createGenericError())
            }
        }
        task.resume()
    }
    
    // MARK: - Private
    
    private func createGenericError() -> Error {
        let genericErrorMessage = "Oops there was a technical error, please try again later"
        let customError = NSError(domain: "",
                                  code: 500,
                                  userInfo: [NSLocalizedDescriptionKey: genericErrorMessage])
        return customError
    }
}
