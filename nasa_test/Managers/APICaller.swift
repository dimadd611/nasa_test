//
//  APICaller.swift
//  nasa_test
//
//  Created by Dumitru Rahmaniuc on 22.07.2022.
//

import Foundation
import UIKit

struct Constants{
    static let baseURL = "https://api.nasa.gov/mars-photos/api/v1/rovers"
    static let APIKey = "NUjzNXhXkAtBeDLA1qsez4ena03pnSn8draS1QEV"
}

enum APIError: Error{
    case failedToGetData
}

class APICaller {
    static let shared = APICaller()
    
    
    public func getData(atPage page: Int, atType type: String, completion: @escaping (Result<[Photo],Error>) -> Void) {
        
        let url = URL(string: "\(Constants.baseURL)/\(type)/photos?sol=\(page)&api_key=\(Constants.APIKey)")!
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            
            if let data = data {
                do {
                    let result = try JSONDecoder().decode(RoverPhoto.self, from: data)
                    completion(.success(result.photos))
                }
                catch {
                    self.handleApiError(error.localizedDescription)
                }
            } else if let error = error {
                self.handleApiError(error.localizedDescription)
            }
        }
        task.resume()
        
        
    }
 
    
    private func handleApiError(_ message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            let cancel = UIAlertAction(title: "Cancel", style: .cancel)
            alert.addAction(cancel)
            UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true)
        }
    }
}

