
import UIKit

class TrailViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    var dataSource : DataSourceTracks!
    var routes = [Route]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.dataSource = DataSourceTracks()
        self.tableView.dataSource = dataSource
        self.tableView.rowHeight = 60
        
        //Fill Trails
        if let routes = Helper.getRoutes() {
            self.routes = routes
        }
        self.dataSource.routes = self.routes
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controlpointVC = segue.destination as? ControlpointViewController {
            let indexPath = self.tableView.indexPathForSelectedRow
            controlpointVC.controlpoints = self.routes[0].trails[indexPath!.row].controlpoints
        }
    }
}

class DataSourceTracks: NSObject, UITableViewDataSource {
    var routes = [Route]()
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.routes[0].trails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "trailCell", for: indexPath) as! TableViewCell
        cell.trail_name.text = self.routes[0].trails[indexPath.row].name
        cell.trail_length.text = String(self.routes[0].trails[indexPath.row].length)
        return cell
    }
}
