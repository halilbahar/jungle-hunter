//
//  ControlpointInfoViewController.swift
//  jungle-hunter-app
//
//  Created by Administrator on 24.03.20.
//  Copyright © 2020 htl-leonding. All rights reserved.
//

import UIKit

class ControlpointInfoViewController: UIViewController {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var latitude: UILabel!
    @IBOutlet weak var longitude: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    var controlpoint: ControlPoint!
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        name.text = controlpoint.name
        latitude.text = "Latitude: " + String(controlpoint.latitude)
        longitude.text = "Longitude: " + String(controlpoint.longitude)
        desc.text = controlpoint.description
        image.image = UIImage(data: try! Data(contentsOf: URL(string: controlpoint.image)!))
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
