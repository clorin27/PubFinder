//
//  IrishPubFinderViewModel.swift
//  IrishPubFinder
//
//  Created by Christelle Lorin on 2/15/18.
//

import Foundation
import UIKit

class IrishPubViewModel {
    
    static let client_id = "B0JZASJL4SNSPPZ11VRKXH033AJEIDWCUINQNZYGQHJKG235"
    static let client_secret = "4TULGL2GVYESDYT1UBDRL1PZBQFHZBK0RSUO5YDWJMEHEL5G"
    
    static let fourSquareVersion = "20140613"
    
    var irishPubs = [IrishPubItem]()
    
    func findIrishPubs(tableView: UITableView) {
        
        let urlString = "https://api.foursquare.com/v2/search/recommendations?ll=\(33.753746),-\(84.386330)&categoryId=52e81612bcbc57f1066b7a06&limit=15&client_id=\(IrishPubViewModel.client_id)&client_secret=\(IrishPubViewModel.client_secret)&v=\(IrishPubViewModel.fourSquareVersion)"
        
        guard let url = URL (string:urlString) else {
            return
        }
        
        let request = NSMutableURLRequest(url: url)
        
        request.httpMethod = "GET"
        
        request.addValue ("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        
        URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            print("data = \(data)")
            print("response = \(response)")
            print("error = \(error)")
            
            guard let data = data else { return }
            
            do {
                
                guard let jsonData = try JSONSerialization.jsonObject(with: data , options: []) as? [String: AnyObject] else { return }
                
               
                guard let responseDictionary = jsonData["response"],
                     let group = responseDictionary["group"] as? [String: Any],
                    let resultsArray = group["results"] as? [AnyObject] else {
                    return
                }
                
                for item in resultsArray {
                    
                    var title =  ""
                    
                    if let venueDictionary = item["venue"] as? [String: Any]?, let name = venueDictionary?["name"] as? String {
                        title = name
                    }
                    
                    let item = IrishPubItem(title: title , distance: 0, rating: "")
                    self.irishPubs.append(item)
                    
                    
                }
                
                DispatchQueue.main.async {
                    tableView.reloadData()
                }
            
                print("json data = \(resultsArray)")
                
                
            } catch {
                
            }
            
        }.resume()
    }
    
}
