class ControlPoint {
    var name: String
    var latitude: Double
    var longitude: Double
    var description: String
    var image: String
    
    init (controlpointDict: [String:Any]) {
        self.name = controlpointDict["name"] as! String
        self.latitude = controlpointDict["latitude"] as! Double
        self.longitude = controlpointDict["longitude"] as! Double
        self.description = controlpointDict["description"] as! String
        self.image = controlpointDict["image"] as! String
    }
    
    init(name: String, latitude: Double, longitude: Double, description: String, image: String) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.description = description
        self.image = image
    }
}
