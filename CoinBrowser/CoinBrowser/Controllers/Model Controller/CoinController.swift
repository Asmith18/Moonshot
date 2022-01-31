//
//  CoinsController.swift
//  CoinBrowser
//
//  Created by adam smith on 1/31/22.
//

import Foundation

class CoinController {
    
    
    //MARK: - Crud
    
    private static var baseURLString = "https://api.coingecko.com/api/v3"
    
    static var fetchCoins: [Coin] = []
    
    
    static func fetchCoins(completion: @escaping (Bool) -> Void) {
        
        var baseURL = URL(string: baseURLString)
        
        baseURL?.appendPathComponent("coins")
        baseURL?.appendPathComponent("list")
        
        guard let finalURL = baseURL else { completion(false); return }
        print(finalURL)
        
        
        URLSession.shared.dataTask(with: finalURL) { data, _, error in
            if let error = error {
                print(error)
                completion(false)
                return
            }
            guard let data = data else {
                print("no data")
                completion(false)
                return
            }
            do {
                if let decodedData = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: String]] {
                    for coinDictionary in decodedData {
                        if let id = coinDictionary["id"],
                           let symbol = coinDictionary["symbol"],
                           let name = coinDictionary["name"] {
                            let newCoin = Coin(id: id, symbol: symbol, name: name)
                            fetchCoins.append(newCoin)
                        }
                    }
                    completion(true)
                    print("set coin")
                }
            } catch {
                print(error)
                completion(false)
            }
        } .resume()
    }
} // end of class
