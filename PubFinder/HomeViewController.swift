//
//  HomeViewController.swift
//  IrishPubFinder
//
//  Created by Christelle Lorin on 2/15/18.
//

import UIKit
import CoreLocation

class HomeViewController: UIViewController, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
    var currentLocation:CLLocationCoordinate2D!
    var flag = true

    @IBOutlet weak var irishPubSearchButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        locationManager.requestWhenInUseAuthorization()
        flag = true
    }

    @IBAction func findIrishPubTapped(_ sender: Any) {
        
        getCurrentLocation()
        
    }
    
    func getCurrentLocation () {
    
        if CLLocationManager.locationServicesEnabled() {
            switch (CLLocationManager.authorizationStatus()) {
            case .authorizedWhenInUse:
                locationManager.startUpdatingLocation()
            default :
                showLocationAlert()
            }
        } else {
            showLocationAlert()
        }

}
    
    func showLocationAlert  () {
        
        let alert = UIAlertController(title: "Location Disabled", message: "Please enable location", preferredStyle: .alert)
        alert.addAction(UIAlertAction (title: "Ok", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSearch" {
            let vc = segue.destination as! SearchViewController
            vc.currentLocation = currentLocation
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
      
        if flag {
            
            currentLocation = locations.last?.coordinate
            locationManager.stopUpdatingLocation()
            flag = false
            performSegue(withIdentifier: "showSearch", sender: self)
            
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
