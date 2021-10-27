//
//  NewsAPIResponse.swift
//  news
//
//  Created by jose juan alcantara rincon on 25/10/21.
//

import Foundation

struct NewsAPIResponse: Decodable {
    let status: String
    let totalResults: Int?
    let articles: [Article]?
    
    let code: String?
    let message: String?
}
