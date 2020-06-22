class ControlPoint {
    var id: String
    var name: String
    var coordinates: [Double]
    var comment: String
    var note: String
    
    init (controlpointDict: [String:Any]) {
        self.id = controlpointDict["id"] as! String
        self.name = controlpointDict["name"] as! String
        self.coordinates = controlpointDict["coordinates"] as! [Double]
        self.comment = controlpointDict["comment"] as! String
        self.note = controlpointDict["note"] as! String
    }
    
    init(id: String, name: String, coordinates: [Double], comment: String, note: String) {
        self.id = id
        self.name = name
        self.coordinates = coordinates
        self.comment = comment
        self.note = note
    }
}
