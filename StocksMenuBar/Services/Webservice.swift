//
//  Webservice.swift
//  StocksMenuBar
//
//  Created by Marcelo Sampaio on 01/08/24.
//

import Foundation

enum NetworkError: Error {
    case invalidResponse
}

class Webservice {
    func getStocks(url: URL) async throws -> [Stock] {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        return try JSONDecoder().decode([Stock].self, from: data)
    }
}
