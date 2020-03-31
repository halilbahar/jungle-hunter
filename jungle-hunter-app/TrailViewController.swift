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
    var routes = [Route]()
        
        override func viewDidLoad() {
            super.viewDidLoad()

            // Do any additional setup after loading the view.
            dataSource = DataSourceTracks()
            tableView.dataSource = dataSource
            self.tableView.rowHeight = 60
            
            //Fill Trails
            /*self.routes = [Route(name: "Europaeische Urwaldroute",start: "Rügen", url: "https://www.alpenvereinaktiv.com/de/liste/urwaldroute/112748914/?share=%7Ezefck7tv%244ossy7ga", description: "entlang E10 West (blauer Balken als Markierung, der E10 ist ein Rundweg auf Rügen), mit Piratensteig (Holztreppen) vor Sassnitz zur Steilküste und wieder hinauf vor Sassnitz Problem: keine E10-Wegetafeln",
                trails:  [
                    Trail(trailID: 01, name: "Kontrollstellen Sassnitz - Stralsund", length: 105.7,
                          controlpoints: [
                            ControlPoint(id: 010, name: "Viktoriablick", coordinates: [
                                    9.228515625,
                                    44.96479793033101
                                    ],
                                comment: "Viktoriablick beim Besucherzentrum Königsstuhl bei Sassnitz/Rügen, NP Jasmund",
                                note: "Rampe"
                            ),
                            ControlPoint(
                                id: 011,
                                name: "Waldhalle",
                                coordinates: [
                                    9.228515625,
                                    44.96479793033101
                                    ],
                                comment:"Waldhalle im NP Jasmund bei Wissowkliniken",
                                note:"Vor der Waldhalle/ Welterbeforum auf Tisch"
                            ),
                            ControlPoint(
                                id: 012,
                                name: "Stralsund",
                                coordinates: [
                                    9.228515625,
                                    44.96479793033101
                                    ],
                                comment:"Brücke über Ostsee / Rügendamm",
                                note:"Vor der Waldhalle/ Welterbeforum auf Tisch"
                            )
                        ]
                    )
                ]
            )]*/
            
            self.dataSource.routes = self.routes
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
            
            controlpointVC.controlpoints = routes[0].trails[indexPath!.row].controlpoints
        }
        
    }


    }

    class DataSourceTracks: NSObject, UITableViewDataSource {
        var routes = [Route]()

         func numberOfSections(in tableView: UITableView) -> Int {
             return 1
         }
         func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return routes[0].trails.count
         }

         func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
             let cell = tableView.dequeueReusableCell(withIdentifier: "trailCell", for: indexPath) as! TableViewCell
             
         
            cell.trail_name.text = routes[0].trails[indexPath.row].name
            cell.trail_length.text = String(routes[0].trails[indexPath.row].length)
           
             return cell
         }
     }
