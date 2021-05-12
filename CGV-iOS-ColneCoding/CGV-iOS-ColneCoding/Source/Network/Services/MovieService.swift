//
//  MovieServiece.swift
//  CGV-iOS-ColneCoding
//
//  Created by kimhyungyu on 2021/05/09.
//

import Foundation
import Moya

public enum MovieService {
    static let key = "4803d10b09913b29b376e511c75a63fb"
    
    case topRated
}

extension MovieService: TargetType {
    public var baseURL: URL {
        return URL(string: GeneralAPI.baseURL)!
    }
    
    public var path: String {
        switch self {
        case .topRated:
//            return "/movie/top_rated?api_key=\(MovieService.key)&language=en-US&page=\(page)"
//            return "/movie/top_rated?api_key=4803d10b09913b29b376e511c75a63fb&language=en-US&page=1"
            return "/movie/top_rated"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .topRated:
            return .get
        }
    }
    
    public var sampleData: Data {
        return  "sampleData".data(using: .utf8)!
    }
    
    public var task: Task {
//        return .requestPlain
        return .requestParameters(parameters: ["api_key": MovieService.key,"language" : "en-US"], encoding: URLEncoding.default)
    }
    
    public var headers: [String : String]? {
        switch self {
        default:
            return ["Content-Type": "application/json"]
        }
    }
    

}
