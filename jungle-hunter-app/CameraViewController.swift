
import UIKit

class CameraViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBAction func retakePhoto(_ sender: Any) {
        openCamera()
    }
    
    @IBAction func saveImage(_ sender: Any) {
        if let image = self.imageView.image {
            if let imageData = image.jpegData(compressionQuality: 1) {
                if let compressedImage = UIImage(data: imageData) {
                    UIImageWriteToSavedPhotosAlbum(compressedImage, nil, nil, nil)
                }
            }
        }
        
        let alert = UIAlertController(title: "Saved", message: "Your photo has been saved", preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alert.addAction(okayAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    let cameraVC = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cameraVC.delegate = self
        cameraVC.allowsEditing = false
        openCamera()
    }
    
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            cameraVC.sourceType = .camera
            present(cameraVC, animated: true, completion: nil)
        } else {
            print("Currently no source type available")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        // populate imageView
        imageView.image = image
        
        picker.dismiss(animated: true, completion: nil)
    }
}
