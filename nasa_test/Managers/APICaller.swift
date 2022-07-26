//
//  APICaller.swift
//  nasa_test
//
//  Created by Dumitru Rahmaniuc on 22.07.2022.
//

import Foundation
final class APICaller{

  static let shared = APICaller()

  private init() {}

  struct Constants {
    static let baseApiURL = "https://api.nasa.gov/mars-photos/api/v1/rovers"
  }

  enum APIError: Error {
    case failedToGetData
  }



  enum HTTPMethod: String {
    case GET
    case POST
  }

  public func getOpportunityRovers(completion: @escaping (Result<RoverPhoto,Error>) -> Void){


    let url = URL(string: "\(Constants.baseApiURL)/opportunity/photos?sol=2&api_key=895TLKaHskn6AUO9MwdzgXneaTJ6JGRm6kqWB6Jd")!
    let task = URLSession.shared.dataTask(with: url) { data, _, error in
      guard let data = data, error == nil else {
        completion(.failure(APIError.failedToGetData))
        return
      }

      do {
        let result = try JSONDecoder().decode(RoverPhoto.self, from: data)

        completion(.success(result))
      }
      catch {
        completion(.failure(error))
      }
    }
      task.resume()



  }
  public func getSpiritRovers(completion: @escaping (Result<RoverPhoto,Error>) -> Void){
    let url = URL(string: "\(Constants.baseApiURL)/spirit/photos?sol=2&api_key=895TLKaHskn6AUO9MwdzgXneaTJ6JGRm6kqWB6Jd")!
    let task = URLSession.shared.dataTask(with: url) { data, _, error in
      guard let data = data, error == nil else {
        completion(.failure(APIError.failedToGetData))
        return
      }

      do {
        let result = try JSONDecoder().decode(RoverPhoto.self, from: data)

        completion(.success(result))
      }
      catch {
        completion(.failure(error))
      }
    }
    task.resume()


  }

  public func getCuriosityRovers(completion: @escaping (Result<RoverPhoto,Error>) -> Void) {
    let url = URL(string: "\(Constants.baseApiURL)/curiosity/photos?sol=3&api_key=895TLKaHskn6AUO9MwdzgXneaTJ6JGRm6kqWB6Jd")!
    let task = URLSession.shared.dataTask(with: url) { data, _, error in
      guard let data = data, error == nil else {
        completion(.failure(APIError.failedToGetData))
        return
      }

      do {
        let result = try JSONDecoder().decode(RoverPhoto.self, from: data)
        completion(.success(result))
      }
      catch {
        completion(.failure(error))
      }
    }
    task.resume()


  }
}
