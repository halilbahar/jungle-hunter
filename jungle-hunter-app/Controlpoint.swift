class ControlPoint {
    var id: Int
    var name: String
    var coordinates: [Double]
    var comment: String
    var note: String
    
    init (controlpointDict: [String:Any]) {
        self.id = controlpointDict["id"] as! Int
        self.name = controlpointDict["name"] as! String
        self.coordinates = controlpointDict["coordinates"] as! [Double]
        self.comment = controlpointDict["comment"] as! String
        self.note = controlpointDict["note"] as! String
    }
    
    init(id: Int, name: String, coordinates: [Double], comment: String, note: String) {
        self.id = id
        self.name = name
        self.coordinates = coordinates
        self.comment = comment
        self.note = note
    }
}
