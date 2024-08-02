//
//  Stock.swift
//  StocksMenuBar
//
//  Created by Marcelo Sampaio on 01/08/24.
//

import Foundation

struct Stock: Decodable {
    let symbol: String
    let description: String
    let price: Double
}
