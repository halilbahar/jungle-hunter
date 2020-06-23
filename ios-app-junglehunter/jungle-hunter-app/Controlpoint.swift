class ControlPoint {
    //var id: String
    var name: String
    //var coordinates: [Double]
    var latitude: Double
    var longitude: Double
    var comment: String
    var note: String
    
    init (controlpointDict: [String:Any]) {
        //self.id = controlpointDict["id"] as! String
        self.name = controlpointDict["name"] as! String
        //self.coordinates = controlpointDict["coordinates"] as! [Double]
        self.latitude = controlpointDict["latitude"] as! Double
        self.longitude = controlpointDict["longitude"] as! Double
        self.comment = controlpointDict["comment"] as! String
        self.note = controlpointDict["note"] as! String
    }
    
    init(/*id: String, */name: String, /*coordinates: [Double], */latitude: Double, longitude: Double,comment: String, note: String) {
        //self.id = id
        self.name = name
        //self.coordinates = coordinates
        self.latitude = latitude
        self.longitude = longitude
        self.comment = comment
        self.note = note
    }
}
