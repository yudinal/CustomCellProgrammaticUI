//
//  RandomUserAPIClient.swift
//  ProgrammaticUserCells
//
//  Created by Lilia Yudina on 1/29/20.
//  Copyright © 2020 Benjamin Stone. All rights reserved.
//

import Foundation

struct RandomUserAPIClient {
  static func fetchRandomUser(with name: String, completion: @escaping (Result<[User], AppError>) -> ()) {
    let endpointURLString = "https://randomuser.me/api/?results=30"
    guard let url = URL(string: endpointURLString) else {
      completion(.failure(.badURL(endpointURLString)))
      return
    }
   
    NetworkHelper.manager.performDataTask(withUrl: url, andMethod:HTTPMethod.get, completionHandler: { (result) in
      switch result {
      case .failure(let appError):
        completion(.failure(.unauthenticated))
      case .success(let data):
        do {
          let podcastSearch = try JSONDecoder().decode(ResultsWrapper.self, from: data)
          completion(.success(podcastSearch.results))
        } catch {
            completion(.failure(.couldNotParseJSON(rawError: error)))
        }
      }
    }
  )}
}
