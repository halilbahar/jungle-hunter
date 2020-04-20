
import UIKit

class ControlpointViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var dataSource: DataSourceControlpoints!
    var controlpoints = [ControlPoint]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.dataSource = DataSourceControlpoints()
        self.tableView.dataSource = self.dataSource
        self.tableView.rowHeight = 80
        
        self.dataSource.controlpoints = self.controlpoints
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controlpointinfoVC = segue.destination as? ControlpointInfoViewController {
            let indexPath = self.tableView.indexPathForSelectedRow
            controlpointinfoVC.controlpoint = self.controlpoints[indexPath!.row]
        }
    }
}

class DataSourceControlpoints: NSObject, UITableViewDataSource {
    var controlpoints = [ControlPoint]()
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.controlpoints.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "controlpointCell", for: indexPath) as! TableViewCell
        cell.controlpoint_name.text = self.controlpoints[indexPath.row].name
        cell.controlpoint_comment.text = self.controlpoints[indexPath.row].comment
        return cell
    }
}
