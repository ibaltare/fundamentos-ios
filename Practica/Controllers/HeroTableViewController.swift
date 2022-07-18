//
//  HeroTableViewController.swift
//  Practica
//
//  Created by Nicolas on 15/07/22.
//

import UIKit

final class HeroTableViewController: UITableViewController {
    
    var heroes: [Hero] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView?.register(UINib(nibName: "HeroTableViewCell", bundle: nil),
            forCellReuseIdentifier: "reuseIdentifier")
        
        title = "Heroes"
        
        let networkModel = NetworkModel.shared
        
        networkModel.getHeroes {  [weak self] heroes, error in
            
            guard let self = self else { return }
            
            if let msg = error {
                self.showAlert(title: "Error", message: msg)
                return
            }
            
            self.heroes = heroes
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return heroes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "reuseIdentifier", for: indexPath) as? HeroTableViewCell else {
            return UITableViewCell()
        }
        cell.set(model: heroes[indexPath.row])
        return cell
    }
    
    // MARK: call when cell clikc
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = DetailViewController()
        nextVC.setHero(model: heroes[indexPath.row])
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
}
