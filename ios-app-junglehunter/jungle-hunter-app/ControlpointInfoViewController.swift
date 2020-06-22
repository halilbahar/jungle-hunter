
import UIKit

class ControlpointInfoViewController: UIViewController {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var latitude: UILabel!
    @IBOutlet weak var longitude: UILabel!
    @IBOutlet weak var comment: UILabel!
    
    var controlpoint: ControlPoint!
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.name.text = self.controlpoint.name
        self.latitude.text = "Breitengrad: " + String(self.controlpoint.coordinates[1])
        self.longitude.text = "Längengrad: " + String(self.controlpoint.coordinates[0])
        self.comment.text = self.controlpoint.comment
    }
}
