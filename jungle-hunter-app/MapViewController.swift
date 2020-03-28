
import UIKit
import Contacts
import MapKit

class MapViewController: UIViewController, UISearchBarDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    var routes = [Route]()
    var controlpoint: ControlPoint!
    
    
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
        
        self.routes = [Route(name: "Europaeische Urwaldroute",start: "Rügen", url: "https://www.alpenvereinaktiv.com/de/liste/urwaldroute/112748914/?share=%7Ezefck7tv%244ossy7ga", description: "entlang E10 West (blauer Balken als Markierung, der E10 ist ein Rundweg auf Rügen), mit Piratensteig (Holztreppen) vor Sassnitz zur Steilküste und wieder hinauf vor Sassnitz Problem: keine E10-Wegetafeln",
            trails:  [
                Trail(trailID: 01, name: "Kontrollstellen Sassnitz - Stralsund", length: 105.7,
                      controlpoints: [
                        ControlPoint(id: 010, name: "Viktoriablick", coordinates: [
                                9.228515625,
                                44.96479793033101
                                ],
                            comment: "Viktoriablick beim Besucherzentrum Königsstuhl bei Sassnitz/Rügen, NP Jasmund",
                            note: "Rampe"
                        ),
                        ControlPoint(
                            id: 011,
                            name: "Waldhalle",
                            coordinates: [
                                9.228515625,
                                44.96479793033101
                                ],
                            comment:"Waldhalle im NP Jasmund bei Wissowkliniken",
                            note:"Vor der Waldhalle/ Welterbeforum auf Tisch"
                        ),
                        ControlPoint(
                            id: 012,
                            name: "Stralsund",
                            coordinates: [
                                9.228515625,
                                44.96479793033101
                                ],
                            comment:"Brücke über Ostsee / Rügendamm",
                            note:"Vor der Waldhalle/ Welterbeforum auf Tisch"
                        )
                    ]
                )
            ]
        )]
         
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
