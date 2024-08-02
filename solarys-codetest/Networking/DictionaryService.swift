//
//  DictionaryService.swift
//  solarys-codetest
//
//  Created by Egon Manya on 30.07.24.
//

import Foundation
import Moya
import RealmSwift

class DictionaryService {
    private let provider = MoyaProvider<DictionaryAPI>()
    private let realm = try! Realm()
    
    func fetchWordDetails(for word: String, completion: @escaping (Result<WordDetail, Error>) -> Void) {
        provider.request(.search(word: word)) { result in
            switch result {
            case .success(let response):
                do {
                    let decoder = JSONDecoder()
                    let wordDetails = try decoder.decode([WordDetail].self, from: response.data)
                    if let firstDetail = wordDetails.first {
                        try self.realm.write {
                            self.realm.add(firstDetail, update: .modified)
                        }
                        completion(.success(firstDetail))
                    } else {
                        completion(.failure(NSError(domain: "No word found", code: 404, userInfo: nil)))
                    }
                } catch let error {
                    print("Decoding error: \(error)")
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

// Mock
class MockDictionaryService: DictionaryService {
    var result: Result<WordDetail, Error>?
    
    override func fetchWordDetails(for word: String, completion: @escaping (Result<WordDetail, Error>) -> Void) {
        if let result = result {
            completion(result)
        }
    }
}
