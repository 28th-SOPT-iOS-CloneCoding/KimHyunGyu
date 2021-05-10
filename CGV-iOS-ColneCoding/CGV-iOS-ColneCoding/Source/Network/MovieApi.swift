//
//  API.swift
//  CGV-iOS-ColneCoding
//
//  Created by kimhyungyu on 2021/05/09.
//

import Foundation
import Moya

class MovieApi {
    static let key = "4803d10b09913b29b376e511c75a63fb"
    static let provider = MoyaProvider<MovieService>()
    
    static func getTopRatedMovie(page: Int, completion: @escaping ([Result]) -> ()) {
        provider.request(.topRated(page: page)) { response in
            switch response{
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
}
