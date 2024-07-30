//
//  DictionaryAPI.swift
//  solarys-codetest
//
//  Created by Egon Manya on 30.07.24.
//

import Foundation
import Moya

enum DictionaryAPI {
    case search(word: String)
}

extension DictionaryAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.dictionaryapi.dev/api/v2/entries/en")!
    }
    
    var path: String {
        switch self {
        case .search(let word):
            return "/\(word)"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    
    var sampleData: Data {
        return Data()
    }
}
