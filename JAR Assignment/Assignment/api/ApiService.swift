//
//  ApiService.swift
//  Assignment
//
//  Created by Kunal on 10/01/25.
//

import Foundation

class ApiService : NSObject {
    private let sourcesURL = URL(string: "https://api.restful-api.dev/objects")!
    
    private let cacheKey = "DeviceDataCacheKey"
    
    func fetchDeviceDetails(completion : @escaping ([DeviceData]) -> ()) async {
        if let cachedData = UserDefaults.standard.data(forKey: cacheKey) {
            do {
                let cachedDeviceData = try JSONDecoder().decode([DeviceData].self, from: cachedData)
                completion(cachedDeviceData)
            } catch {
                print(error)
            }
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: sourcesURL)
            // save
            UserDefaults.standard.set(data, forKey: cacheKey)
            try completion(JSONDecoder().decode([DeviceData].self, from: data))
        } catch {
            print(error)
        }
    }
}
