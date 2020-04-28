
import UIKit
import Contacts
import MapKit

class MapViewController: UIViewController, UISearchBarDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var routes = [Route]()
    var selectedControlpoint: ControlPoint!
    let routeQueue: DispatchQueue = DispatchQueue.init(label: "MapView-RouteQueue")
    var resultSearchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationController?.view.backgroundColor = .clear
        
        let searchTable = storyboard!.instantiateViewController(withIdentifier: "SearchTable") as! SearchTableViewController
        resultSearchController = UISearchController(searchResultsController: searchTable)
        resultSearchController.searchResultsUpdater = searchTable
        
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for controlpoints"
        navigationItem.searchController = resultSearchController
        searchTable.mapSearch = self
        
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        definesPresentationContext = true
        
        searchTable.mapView = mapView
        
        self.mapView.delegate = self
        routeQueue.async {
            if let routes = Helper.getRoutes() {
                self.routes = routes
            }
            DispatchQueue.main.sync {
                self.drawControlpoints()
            }
        }
        self.drawTrails()
    }
    
    func fetchData() -> [Coordinate] {
        let gpxParser = GpxParser()
        var coordinatesFetch = [Coordinate]()
        gpxParser.parseFeed(urlString: "http://localhost:3000") { (coordinates) in
            coordinatesFetch = coordinates
        }
        print(coordinatesFetch)
        return coordinatesFetch
    }
    
    func drawTrails() {
        let coordinates = fetchData()
        var locations = [CLLocationCoordinate2D]()
        
        for coordinate in coordinates {
            locations.append(CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude))
        }
        
        let polyline = MKPolyline(coordinates: locations, count: locations.count)
        self.mapView.addOverlay(polyline)
    }
    
    func drawControlpoints() {
        for trail in self.routes[0].trails {
            var mapTrail = [MKPointAnnotation]()
            for controlpoint in trail.controlpoints {
                let annotation = MKPointAnnotation()
                annotation.title = controlpoint.name
                annotation.coordinate = CLLocationCoordinate2DMake(controlpoint.coordinates[0], controlpoint.coordinates[1])
                
                mapTrail.append(annotation)
            }
            self.mapView.showAnnotations(mapTrail, animated: true)
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolyline {
            let polylineRenderer = MKPolylineRenderer(overlay: overlay)
            polylineRenderer.strokeColor = UIColor.red.withAlphaComponent(0.5)
            polylineRenderer.lineWidth = 5
            return polylineRenderer
        }
        return overlay as! MKOverlayRenderer
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        for trail in routes[0].trails {
            for controlpoint in trail.controlpoints {
                if(controlpoint.name == mapView.selectedAnnotations[0].title!!) {
                    self.selectedControlpoint = controlpoint
                    break
                }
            }
        }
        performSegue(withIdentifier: "ControlpointInfo", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controlpointInfoVC = segue.destination as? ControlpointInfoViewController {
            controlpointInfoVC.controlpoint = selectedControlpoint
        }
    }
    
    func zoomIn(annotation: MKAnnotation) {
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: annotation.coordinate, span: span)
        mapView.setRegion(region, animated: true)
        self.resultSearchController.dismiss(animated: true, completion: nil)
    }
}
