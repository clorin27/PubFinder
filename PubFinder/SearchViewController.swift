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
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: IrishPubViewModel.FetchComplete), object: nil, queue: nil) { [weak self] _ in  self?.refreshTableView()
        }
    }
    
    func refreshTableView() {
        irishPubTableVIew.reloadData()
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
        cell.priceLabel.text = irishPubItem.priceTier
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let irishPubItem = viewModel.irishPubs[indexPath.row]
        
      let detailVC = SearchDetailViewController()
      detailVC.urlString = irishPubItem.url
        
        navigationController?.pushViewController(detailVC, animated: false)
    }
    
}
