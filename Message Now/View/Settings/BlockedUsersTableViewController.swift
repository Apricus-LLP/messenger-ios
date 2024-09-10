//
//  BlockedUsersTableViewController.swift
//  SmartTalk MVP
//
//  Created by Pavel Mac on 8/25/24.
//  Copyright © 2024 Apricus-LLP. All rights reserved.
//

import UIKit

class BlockedUsersTableViewController: UITableViewController {

    
    private let vm = BlockedViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        initFetch()
    }
    
    func initFetch() {
        vm.reloadTableViewClouser = { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
        vm.initFetch()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.numberOfCells!
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "blockCell", for: indexPath) as! BlockedUsersTableViewCell
        cell.userVM = vm.userViewModel[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
}
