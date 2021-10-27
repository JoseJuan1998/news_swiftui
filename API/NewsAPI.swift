//
//  NewsAPI.swift
//  news
//
//  Created by jose juan alcantara rincon on 26/10/21.
//

import Foundation

struct NewsAPI {
    static let shared = NewsAPI()
    private init() {}
    
    private let url = URL(string: "https://newsapi.org/v2/everything?q=tesla&from=2021-09-27&sortBy=publishedAt&apiKey=eda0d5bca92046afb87388ba5766df3e")
    private let apiKey = "eda0d5bca92046afb87388ba5766df3e"
    private let session = URLSession.shared
    private let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
    
    func fetch() async throws -> [Article] {
        let (data, response) = try await session.data(from: url!)
        
        guard let response  = response as? HTTPURLResponse else {
            throw generateError(description: "Bad Response")
        }
        
        switch response.statusCode {
        case (200...299), (400...499):
            let apiResponse = try jsonDecoder.decode(NewsAPIResponse.self, from: data)
            if apiResponse.status == "ok" {
                return apiResponse.articles ?? []
            }else{
                throw generateError(description: apiResponse.message ?? "An error occured")
            }
        default:
            throw generateError(description: "An error occured")
        }
    }
    
    private func generateError(code: Int = -1, description: String) -> Error {
        NSError(domain: "NewsAPI", code: code, userInfo: [NSLocalizedDescriptionKey: description])
    }
}
