//
//  MapViewController.swift
//  jungle-hunter-app
//
//  Created by Sonja Cao on 28.02.20.
//  Copyright © 2020 htl-leonding. All rights reserved.
//

import UIKit
import Contacts
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       let coords = CLLocationCoordinate2DMake(51.5083, -0.1384)

        let address = [/*CNPostalAddressStreetKey: "181 Piccadilly, St. James's", CNPostalAddressCityKey: "London", CNPostalAddressPostalCodeKey: "W1A 1ER",*/ CNPostalAddressISOCountryCodeKey: "GB"]
        
        let place = MKPlacemark(coordinate: coords, addressDictionary: address)
        
        mapView.addAnnotation(place)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
