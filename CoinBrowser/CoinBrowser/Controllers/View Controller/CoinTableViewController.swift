//
//  CoinsTableViewController.swift
//  CoinBrowser
//
//  Created by adam smith on 1/31/22.
//

import UIKit

class CoinTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        CoinController.fetchCoins { success in
            if success {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        


    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return CoinController.fetchCoins.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "coinCell", for: indexPath)
        let coin = CoinController.fetchCoins[indexPath.row]
        cell.textLabel?.text = coin.name
        cell.detailTextLabel?.text = "\(coin.id) \(coin.symbol)"
        

        return cell
    }


}
