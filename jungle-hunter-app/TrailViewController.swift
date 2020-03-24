//
//  TrailViewController.swift
//  jungle-hunter-app
//
//  Created by Administrator on 24.03.20.
//  Copyright © 2020 htl-leonding. All rights reserved.
//

import UIKit

class TrailViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    var dataSource : DataSourceTracks!
        var trails = [Trail]()
        
        override func viewDidLoad() {
            super.viewDidLoad()

            // Do any additional setup after loading the view.
            dataSource = DataSourceTracks()
            tableView.dataSource = dataSource
            self.tableView.rowHeight = 100
            
            //Fill Tracks
            self.trails = [
                Trail(name: "Far far Away", country: "A", controlpoints: [
                 ControlPoint(name: "Tragwein", latitude: 48.33, longitude: 14.62, description: "A kleiner Ort", image: "https://media.images-tiscover.com/at/images/RGN/295/RGN134295at/tragwein03-oberoesterreich.jpg"),
                 ControlPoint(name: "Eferding", latitude: 48.3, longitude: 14.02, description: "a größerer Ort", image: "https://media.images-tiscover.com/at/images/RGN/295/RGN134295at/tragwein03-oberoesterreich.jpg"),
                 ControlPoint(name: "Stroheim", latitude: 48.19, longitude: 13.56, description: "is des a Ort", image: "https://austria-forum.org/attach/Wissenssammlungen/Bildlexikon_%C3%96sterreich/Orte_in_Ober%C3%B6sterreich/Stroheim/Stroheim/cfressel_Gemeinde_Luftaufnahme.jpg")
                ]),
                Trail(name: "Schule", country: "A", controlpoints: [
                    ControlPoint(name: "Linz", latitude: 48.18, longitude: 14.18, description: "Landeshauptstadt", image: "https://upload.wikimedia.org/wikipedia/commons/7/77/Linz_view_2.jpg"),
                    ControlPoint(name: "Leonding", latitude: 48.16, longitude: 14.15, description: "Ort der HTL", image: "https://i.ytimg.com/vi/JDQ5O3CNzuM/maxresdefault.jpg")
                ])
            ]
            
            self.dataSource.trails = self.trails
        }
        

        /*
        // MARK: - Navigation

        // In a storyboard-based application, you will often want to do a little preparation before navigation
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            // Get the new view controller using segue.destination.
            // Pass the selected object to the new view controller.
        }
        */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controlpointVC = segue.destination as? ControlpointViewController {
            let indexPath = tableView.indexPathForSelectedRow
            
            controlpointVC.controlpoints = trails[indexPath!.row].controlpoints
        }
        
    }


    }

    class DataSourceTracks: NSObject, UITableViewDataSource {
        var trails = [Trail]()

         func numberOfSections(in tableView: UITableView) -> Int {
             return 1
         }
         func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return trails.count
         }

         func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
             let cell = tableView.dequeueReusableCell(withIdentifier: "trailCell", for: indexPath) as! TableViewCell
             
         
            cell.trail_name.text = trails[indexPath.row].name
            cell.trail_country.text = trails[indexPath.row].country
            cell.trail_start.text = trails[indexPath.row].controlpoints[0].name
            cell.trail_end.text = trails[indexPath.row].controlpoints[trails[indexPath.row].controlpoints.count - 1].name
             
             return cell
         }
     }
