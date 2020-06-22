
import Foundation

class GpxParser: NSObject, XMLParserDelegate {
    
    private var coordinates = [Coordinate]()
    private var parserCompletionHandler: (([Coordinate]) -> Void)?
    
    func parseFeed(urlString: String, completionHandler: (([Coordinate]) -> Void)?) {
        self.parserCompletionHandler = completionHandler
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                let parser = XMLParser(data: data)
                parser.delegate = self
                parser.parse()
            }
        }
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == "trkpt" {
            if let latitude = attributeDict["lat"], let longitude = attributeDict["lon"] {
                if let latitudeDouble = Double(latitude), let longitudeDouble = Double(longitude) {
                    self.coordinates.append(Coordinate(latitude: latitudeDouble, longitude: longitudeDouble))
                }
            }
        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        self.parserCompletionHandler?(self.coordinates)
    }
}
