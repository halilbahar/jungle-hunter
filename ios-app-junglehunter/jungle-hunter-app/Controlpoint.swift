class ControlPoint {
    var name: String
    var latitude: Double
    var longitude: Double
    var comment: String
    var note: String
    
    init (controlpointDict: [String:Any]) {
        self.name = controlpointDict["name"] as! String
        self.latitude = controlpointDict["latitude"] as! Double
        self.longitude = controlpointDict["longitude"] as! Double
        self.comment = controlpointDict["comment"] as! String
        self.note = controlpointDict["note"] as! String
    }
    
    init(name: String, latitude: Double, longitude: Double,comment: String, note: String) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.comment = comment
        self.note = note
    }
}
