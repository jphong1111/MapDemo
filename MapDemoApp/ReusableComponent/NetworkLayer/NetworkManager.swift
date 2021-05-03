//
//  NetworkManager.swift
//  MapDemoApp
//
//  Created by JungpyoHong on 4/25/21.
//

import Foundation

class NetworkManager {
    static let manager = NetworkManager()
    
    private init() {
    }
    
    func fetchData<T>(from url: String, completion: @escaping (Result<T, AppError>) -> Void) where T: Decodable {
        guard let finalURL = URL(string: url) else {
            completion(.failure(.badUrl))
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: finalURL) { data, response, error in
            let completionOnMain: (Result<T, AppError>) -> Void = { result in
                DispatchQueue.main.async {
                    completion(result)
                }
            }
            
            guard error == nil else {
                completionOnMain(.failure(.serverError))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completionOnMain(.failure(.badResponse))
                return
            }
            
            switch response.statusCode {
            case 200...299:
                guard let unwrappedData = data else {
                    completionOnMain(.failure(.noData))
                    return
                }
                do {
                    let data = try JSONDecoder().decode(T.self, from: unwrappedData)
                    completionOnMain(.success(data))
                } catch {
                    print(error)
                    completionOnMain(.failure(.parseError))
                }
                
            default:
                completionOnMain(.failure(.genericError("Something went wrong")))
            }
        }
        dataTask.resume()
    }
}

