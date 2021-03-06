
import UIKit

class PhotobookViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var createPdfButton: UIButton!
    
    @IBAction func uploadPhoto(_ sender: Any) {
        self.imagePickerController.allowsEditing = false
        self.imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
    
    let imagePickerController = UIImagePickerController()
    var photos = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.imagePickerController.delegate = self
        
        if(!MyPhotobook.photos.isEmpty){
            self.createPdfButton.isEnabled = true
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let uploadedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            //self.photos.append(uploadedImage)
            MyPhotobook.photos.append(uploadedImage)
            print(uploadedImage)
        }
        dismiss(animated: true, completion: nil)
        self.collectionView.reloadData()
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MyPhotobook.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cvCell", for: indexPath) as! PhotobookCollectionViewCell
        cell.photobookImageView.image = MyPhotobook.photos[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        return CGSize(width: view.frame.width, height: 150)
    }
    
    @IBAction func createPdf(_ sender: Any) {
        UploadImages.upload(photos: MyPhotobook.photos)
    }
}
