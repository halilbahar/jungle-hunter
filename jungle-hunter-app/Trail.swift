class Trail {
    var trailID: String
    var name: String
    var length: Double
    var controlpoints: [ControlPoint]
    
    init (trailDict: [String:Any]) {
        self.trailID = trailDict["trailID"] as! String
        self.name = trailDict["name"] as! String
        self.length = Double(trailDict["length"] as! String)!
        self.controlpoints = (trailDict["controlpoints"] as! [[String:Any]]).map{ControlPoint(controlpointDict: $0)}
    }
    
    init (trailID: String ,name: String, length: Double, controlpoints: [ControlPoint]) {
        self.trailID = trailID
        self.name = name
        self.length = length
        self.controlpoints = controlpoints
     }
}
