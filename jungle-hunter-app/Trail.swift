class Trail {
    var name: String
    var country: String
    var controlpoints: [ControlPoint]
    
    init (trailDict: [String:Any]) {
        self.name = trailDict["name"] as! String
        self.country = trailDict["country"] as! String
        self.controlpoints = trailDict["controlpoints"] as! [ControlPoint]
    }
    
    init (name: String, country: String, controlpoints: [ControlPoint]) {
        self.name = name
        self.country = country
        self.controlpoints = controlpoints
     }
}
