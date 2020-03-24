//
//  ControlpointViewController.swift
//  jungle-hunter-app
//
//  Created by Administrator on 24.03.20.
//  Copyright © 2020 htl-leonding. All rights reserved.
//

import UIKit

class ControlpointViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
     var dataSource: DataSourceControlpoints!
        var controlpoints = [ControlPoint]()
        
        override func viewDidLoad() {
            super.viewDidLoad()

            // Do any additional setup after loading the view.
            dataSource = DataSourceControlpoints()
            tableView.dataSource = dataSource
            self.tableView.rowHeight = 100
            
            self.dataSource.controlpoints = self.controlpoints
        }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let controlpointinfoVC = segue.destination as? ControlpointInfoViewController {
                let indexPath = tableView.indexPathForSelectedRow
                
                controlpointinfoVC.controlpoint = controlpoints[indexPath!.row]
            }
            
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

    class DataSourceControlpoints: NSObject, UITableViewDataSource {
       var controlpoints = [ControlPoint]()

        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return controlpoints.count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "controlpointCell", for: indexPath) as! TableViewCell
            
            cell.controlpoint_name.text = controlpoints[indexPath.row].name
            cell.controlpoint_description.text = controlpoints[indexPath.row].description
            cell.controlpoint_image.image = UIImage(data: try! Data(contentsOf: URL(string: controlpoints[indexPath.row].image)!))
            
            return cell
        }
    }
