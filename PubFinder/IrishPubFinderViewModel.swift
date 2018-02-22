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
    
    static let FetchComplete =
    "FetchComplete"
    
    var irishPubs = [IrishPubItem]()
    
    init() {
        findIrishPubs()
    }
    
    func findIrishPubs() {
        
        let urlString = "https://api.foursquare.com/v2/search/recommendations?ll=\(33.753746),-\(84.386330)&categoryId=52e81612bcbc57f1066b7a06&limit=15&client_id=\(IrishPubViewModel.client_id)&client_secret=\(IrishPubViewModel.client_secret)&v=\(IrishPubViewModel.fourSquareVersion)"
        
        print("URL STRING = \(urlString)")

        
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
                    var priceTier = ""
                    var url = ""
                    
                    
                    if let venueDictionary = item["venue"] as? [String: Any]? {
                        
                        if let name = venueDictionary?["name"]as? String {
                           title = name
                        }
                        
                        if let priceDictionary = venueDictionary?["price"] as? [String: Any]?, let messageString = priceDictionary?["message"] as? String {
                            priceTier = messageString
                        }
                        
                        if let urlString = venueDictionary? ["url"]as? String {
                            url = urlString
                        }
                        
    
                        
                    }
                    
                    let item = IrishPubItem(title: title , distance: 0, rating: "", priceTier: priceTier, url: url)
                    self.irishPubs.append(item)
                    
                    
                }
                
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: Notification.Name(rawValue: IrishPubViewModel.FetchComplete), object: nil)
                    
                }
            
                print("json data = \(resultsArray)")
                
                
            } catch {
                
            }
            
        }.resume()
    }
    
}
