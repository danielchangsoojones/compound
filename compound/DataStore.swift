//
//  DataStore.swift
//  compound
//
//  Created by Daniel Jones on 2/13/24.
//

import Foundation

class DataStore {
    func fetchAssetsFromAPI() async throws -> [Asset] {
        let url = URL(string: "https://alexandfox.github.io/api/markets-data.json")
        let (data, _) = try await URLSession.shared.data(from: url!)
        let decoded = try JSONDecoder().decode(AssetsResponse.self, from: data)
        return decoded.assets
    }
}

struct AssetsResponse: Decodable {
    let assets: [Asset]
}

struct Asset: Decodable {
    let name: String
    let symbol: String
    let image: String
    let price: Float
    let total_supply: Float
    let collateral_factor: Int
    let liquidation_factor: Int
}
