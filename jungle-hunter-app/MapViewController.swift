
import UIKit
import Contacts
import MapKit

class MapViewController: UIViewController, UISearchBarDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    var routes = [Route]()
    var controlpoint: ControlPoint!
    let routeQueue: DispatchQueue = DispatchQueue.init(label: "MapView-RouteQueue")
    
    @IBAction func searchButton(_ sender: Any) {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        present(searchController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationController?.view.backgroundColor = .clear
        
        self.mapView.delegate = self
        routeQueue.async {
            if let routes = Helper.getRoutes() {
                self.routes = routes
            }
        }
        
        /*
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
         */
        
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
         }
         */
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        for trail in routes[0].trails {
            for cpoint in trail.controlpoints {
                if(cpoint.name == mapView.selectedAnnotations[0].title!!) {
                    self.controlpoint = cpoint
                    break
                }
            }
        }
        performSegue(withIdentifier: "controlpointinfo", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controlpointinfoVC = segue.destination as? ControlpointInfoViewController {
            
            controlpointinfoVC.controlpoint = controlpoint
        }
        
    }
    
}
