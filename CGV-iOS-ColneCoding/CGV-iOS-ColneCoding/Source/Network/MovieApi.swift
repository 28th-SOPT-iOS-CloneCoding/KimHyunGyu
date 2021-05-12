//
//  API.swift
//  CGV-iOS-ColneCoding
//
//  Created by kimhyungyu on 2021/05/09.
//

import Foundation
import Moya
import RxSwift

class MovieApi {
    static let shared = MovieApi()
    static let provider = MoyaProvider<MovieService>()
    
    func getTopRatedMovie(completion: @escaping ([Result]) -> ()) {
        MovieApi.provider.request(.topRated) { response in
            switch response {
            case .success(let result):
                do {
                    let results = try JSONDecoder().decode(MovieModel.self, from: result.data)
                    completion(results.results)
                } catch let err {
                    print("JSONDecode: \(err.localizedDescription)")
                    debugPrint(err)
                }
            case .failure(let err):
                
                print(".failure: \(err.localizedDescription)")
            }
        }
    }
    
    func getMoviePoster(path: String, completion: @escaping (Data) -> ()) {
        MovieApi.provider.rx.request(.getPoster(path: path)).subscribe { event in
            switch event {
            case .success(let response):
                completion(response.data)
            case .error(let err):
                print(err)
                
            }
            
        }
    }
}
