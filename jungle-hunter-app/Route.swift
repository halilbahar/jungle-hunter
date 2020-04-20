class Route {
    var name: String
    var start: String
    var url: String
    var description: String
    var trails: [Trail]
    
    init (routeDict: [String:Any]) {
        self.name = routeDict["name"] as! String
        self.start = routeDict["start"] as! String
        self.url = routeDict["url"] as! String
        self.description = routeDict["description"] as! String
        self.trails = (routeDict["trails"] as! [[String:Any]]).map{ Trail(trailDict: $0) }
    }

    init (name: String, start: String, url: String, description: String,trails: [Trail]) {
        self.name = name
        self.start = start
        self.url = url
        self.description = description
        self.trails = trails
     }
}
