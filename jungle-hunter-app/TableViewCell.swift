
import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var trail_name: UILabel!
    @IBOutlet weak var trail_length: UILabel!
        
    @IBOutlet weak var controlpoint_name: UILabel!
    @IBOutlet weak var controlpoint_comment: UILabel!

    @IBOutlet weak var search_title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
