//
//  Decodable+CreateModel.swift
//  Events
//
//  Created by Luntu on 2020/07/27.
//  Copyright © 2020 Luntu. All rights reserved.
//

import Foundation

extension Decodable {
    
    static func model<T: Decodable>(from dictionary: [String: Any]) -> T? {
        do {
            let decoder = JSONDecoder()
            let data = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
            let response = try decoder.decode(T.self, from: data)
            return response
        } catch {
            return nil
        }
    }
    
    static func model<T: Decodable>(from dictionary: [Any]) -> [T]? {
        do {
            let decoder = JSONDecoder()
            let data = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
            let response = try decoder.decode([T].self, from: data)
            return response
        } catch {
            return nil
        }
    }
}
