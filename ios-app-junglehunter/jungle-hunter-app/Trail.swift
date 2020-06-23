class Trail {
    var name: String
    var length: Double
    var controlpoints: [ControlPoint]
    
    init (trailDict: [String:Any]) {
        self.name = trailDict["name"] as! String
        self.length = trailDict["length"] as! Double
        self.controlpoints = (trailDict["controlPoints"] as! [[String:Any]]).map{ ControlPoint(controlpointDict: $0) }
    }
    
    init (name: String, length: Double, controlpoints: [ControlPoint]) {
        self.name = name
        self.length = length
        self.controlpoints = controlpoints
     }
}
