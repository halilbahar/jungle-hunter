class ControlPoint {
    var name: String
    var coordinate: Coordinate
    var comment: String
    var note: String
    
    init (controlpointDict: [String:Any]) {
        self.name = controlpointDict["name"] as! String
        self.coordinate = Coordinate(latitude: controlpointDict["latitude"] as! Double, longitude: controlpointDict["longitude"] as! Double)
        self.comment = controlpointDict["comment"] as! String
        self.note = controlpointDict["note"] as! String
    }
    
    init(name: String, coordinate: Coordinate, comment: String, note: String) {
        self.name = name
        self.coordinate = coordinate
        self.comment = comment
        self.note = note
    }
}
