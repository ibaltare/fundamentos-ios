//
//  HeroTableViewController.swift
//  Practica
//
//  Created by Nicolas on 15/07/22.
//

import UIKit

class HeroTableViewController: UITableViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView?.register(UINib(nibName: "HeroTableViewCell", bundle: nil),
            forCellReuseIdentifier: "reuseIdentifier")
        
        title = "hello"
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 100
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "reuseIdentifier", for: indexPath) as? HeroTableViewCell else {
            return UITableViewCell()
        }
        
        cell.heroName.text = "Goku"
        cell.heroDescription.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."

        return cell
    }
    
    // MARK: call when cell clikc
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
