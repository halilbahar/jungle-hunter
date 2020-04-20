import Foundation

class Helper {
    static func getRoutes() -> [Route]? {
        let url = URL(string: "http://www.mocky.io/v2/5e9df7e6340000597a6eead1")
        if let dataUrl = url {
            let data = try? Data(contentsOf: dataUrl)
            if let downloadedData = data {
                if let jsonObject = try? JSONSerialization.jsonObject(with: downloadedData, options: []) as? [[String:Any]]{
                    return jsonObject.map{ Route(routeDict: $0) }
                }
            }
        }
        return nil
    }
}
