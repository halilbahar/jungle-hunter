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
        if let routes = Helper.getRoutes() {
            self.routes = routes
        }
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
