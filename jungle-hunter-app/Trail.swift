class Trail {
    var trailID: Int
    var name: String
    var length: Double
    var controlpoints: [ControlPoint]
    
    init (trailDict: [String:Any]) {
        self.trailID = trailDict["trailID"] as! Int
        self.name = trailDict["name"] as! String
        self.length = trailDict["length"] as! Double
        self.controlpoints = trailDict["controlpoints"] as! [ControlPoint]
    }
    
    init (trailID: Int ,name: String, length: Double, controlpoints: [ControlPoint]) {
        self.trailID = trailID
        self.name = name
        self.length = length
        self.controlpoints = controlpoints
     }
}
