
import UIKit
import Contacts
import MapKit

class MapViewController: UIViewController, UISearchBarDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    var trails = [Trail]()
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
        
        self.trails = [
                    Trail(name: "Far far Away", country: "A", controlpoints: [
                     ControlPoint(name: "Tragwein", latitude: 48.33, longitude: 14.62, description: "A kleiner Ort", image: "https://media.images-tiscover.com/at/images/RGN/295/RGN134295at/tragwein03-oberoesterreich.jpg"),
                     ControlPoint(name: "Eferding", latitude: 48.3, longitude: 14.02, description: "a größerer Ort", image: "https://media.images-tiscover.com/at/images/RGN/295/RGN134295at/tragwein03-oberoesterreich.jpg"),
                     ControlPoint(name: "Stroheim", latitude: 48.19, longitude: 13.56, description: "is des a Ort", image: "https://austria-forum.org/attach/Wissenssammlungen/Bildlexikon_%C3%96sterreich/Orte_in_Ober%C3%B6sterreich/Stroheim/Stroheim/cfressel_Gemeinde_Luftaufnahme.jpg")
                    ]),
                    Trail(name: "Schule", country: "A", controlpoints: [
                        ControlPoint(name: "Linz", latitude: 48.18, longitude: 14.18, description: "Landeshauptstadt", image: "https://upload.wikimedia.org/wikipedia/commons/7/77/Linz_view_2.jpg"),
                        ControlPoint(name: "Leonding", latitude: 48.16, longitude: 14.15, description: "Ort der HTL", image: "https://i.ytimg.com/vi/JDQ5O3CNzuM/maxresdefault.jpg")
                    ])
                ]
         
         for trail in self.trails {
             var mapTrail = [MKPointAnnotation]()
             for controlpoint in trail.controlpoints {
                let annotation = MKPointAnnotation()
                 annotation.title = controlpoint.name
                 annotation.coordinate = CLLocationCoordinate2DMake(controlpoint.latitude, controlpoint.longitude)
                 
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
         for trail in trails {
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
