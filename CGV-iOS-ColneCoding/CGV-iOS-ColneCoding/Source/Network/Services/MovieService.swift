//
//  MovieServiece.swift
//  CGV-iOS-ColneCoding
//
//  Created by kimhyungyu on 2021/05/09.
//

import Foundation
import Moya

public enum MovieService {
    case topRated(page: Int)
}

extension MovieService: TargetType {
    public var baseURL: URL {
        return URL(string: GeneralAPI.baseURL)!
    }
    
    public var path: String {
        switch self {
        case .topRated:
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
        return .requestPlain
    }
    
    public var headers: [String : String]? {
        switch self {
        default:
            return ["Content-Type": "application/json"]
        }
    }
    

}
