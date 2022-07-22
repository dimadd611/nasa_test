//
//  APICaller.swift
//  nasa_test
//
//  Created by Dumitru Rahmaniuc on 22.07.2022.
//

import Foundation


struct Constants{
    static let baseURL = "https://api.nasa.gov/mars-photos/api/v1/rovers"
    static let APIKey = "NUjzNXhXkAtBeDLA1qsez4ena03pnSn8draS1QEV"
    static let opportunityType = "/opportunity/photos?sol=1000&api_key="
    static let curiosityType = "/curiosity/photos?sol=1000&api_key="
    static let spiritType = "/spirit/photos?sol=1000&api_key="
}

enum APIError: Error{
    case failedToGetData
}

class APICaller{
    static let shared = APICaller()
    
    
    public func getDataCuriosity(completion: @escaping (Result<RoverPhoto,Error>) -> Void) {
      let url = URL(string: "\(Constants.baseURL)/curiosity/photos?sol=1000&api_key=895TLKaHskn6AUO9MwdzgXneaTJ6JGRm6kqWB6Jd")!
      let task = URLSession.shared.dataTask(with: url) { data, _, error in
        guard let data = data, error == nil else {
          completion(.failure(APIError.failedToGetData))
          return
        }

        do {
          let result = try JSONDecoder().decode(RoverPhoto.self, from: data)
            print(result)
          completion(.success(result))
        }
        catch {
          completion(.failure(error))
        }
      }
      task.resume()


    }
    
    func getDataOpportunity(completion: @escaping (Result<RoverPhoto, Error>) -> Void){
        let url = URL(string: "\(Constants.baseURL)\(Constants.opportunityType)\(Constants.APIKey)")!
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(APIError.failedToGetData))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(RoverPhoto.self, from: data)
                completion(.success(result))
            }
            catch{
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func getDataSpirit(completion: @escaping (Result<[RoverPhoto], Error>) -> Void){
        let url = URL(string: "\(Constants.baseURL)\(Constants.spiritType)\(Constants.APIKey)")!
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(APIError.failedToGetData))
                return
            }
            
            do {
                let result = try JSONDecoder().decode([RoverPhoto].self, from: data)
                completion(.success(result))
            }
            catch{
                completion(.failure(error))
            }
        }
        task.resume()
    }
}

