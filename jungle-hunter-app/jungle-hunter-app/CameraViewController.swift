//
//  CameraViewController.swift
//  jungle-hunter-app
//
//  Created by Sonja Cao on 28.02.20.
//  Copyright © 2020 htl-leonding. All rights reserved.
//

import UIKit

class CameraViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    let cameraVC = UIImagePickerController()

    @IBOutlet weak var imageView: UIImageView!
    
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
    
    @IBAction func retakePhoto(_ sender: Any) {
        openCamera()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        // populate imageView
        imageView.image = image
        
        picker.dismiss(animated: true, completion: nil)
    }
}
