//
//  SearchViewController.swift
//  IrishPubFinder
//
//  Created by Christelle Lorin on 2/15/18.
//

import UIKit



class SearchViewController: UIViewController {
    
    let viewModel = IrishPubViewModel()
    
    @IBOutlet weak var irishPubTableVIew: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.findIrishPubs(tableView: irishPubTableVIew)
    }

}


extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.irishPubs.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let irishPubItem = viewModel.irishPubs[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! SearchTableViewCell
        cell.titleLabel.text = irishPubItem.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    }
    
}
