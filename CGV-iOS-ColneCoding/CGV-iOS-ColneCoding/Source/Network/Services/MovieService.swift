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
    
    case nowPlaying
    case getPoster(path: String)
}

extension MovieService: TargetType {
    public var baseURL: URL {
        switch self {
        case .nowPlaying:
            return URL(string: GeneralAPI.baseURL)!
        case .getPoster(_):
            return URL(string: GeneralAPI.imageURL)!
        }
    }
    
    public var path: String {
        switch self {
        case .nowPlaying:
//            return "/movie/top_rated"
        return "/movie/now_playing"
        case .getPoster(let path):
            return "/\(path)"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .nowPlaying, .getPoster:
            return .get
        }
    }
    
    public var sampleData: Data {
        return  "sampleData".data(using: .utf8)!
    }
    
    public var task: Task {
//        return .requestPlain
        switch self {
        case .nowPlaying:
            return .requestParameters(parameters: ["api_key": MovieService.key,"language" : "ko"], encoding: URLEncoding.default)
        case .getPoster(_):
            return .requestPlain
        }
    }
    
    public var headers: [String : String]? {
        switch self {
        default:
            return ["Content-Type": "application/json"]
        }
    }
    

}
