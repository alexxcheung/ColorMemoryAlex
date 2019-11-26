//
//  ScoreboardViewController.swift
//  ColorMemory
//
//  Created by Alex Cheung on 26/11/2019.
//  Copyright © 2019 Alex Cheung. All rights reserved.
//

import UIKit

class ScoreboardViewController: UIViewController {
    
    var rankList = [String]()

    @IBOutlet weak var rankTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
      
    }
    
    func setupTableView() {
        rankTableView.delegate = self
        rankTableView.dataSource = self
        rankTableView.register(UINib(nibName: "RankTableViewCell", bundle: nil), forCellReuseIdentifier: "RankTableViewCell")
        rankTableView.tableFooterView = UIView()
    }
}

extension ScoreboardViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if rank.rankList.count > 10 {
            return 10
        } else {
            return rank.rankList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RankTableViewCell", for: indexPath) as! RankTableViewCell
            
        cell.rankLabel.text = String(indexPath.row + 1)
        cell.nameLabel.text = rank.rankList[indexPath.row].username
        cell.scoreLabel.text = String(rank.rankList[indexPath.row].score)

        return cell
    }
}
