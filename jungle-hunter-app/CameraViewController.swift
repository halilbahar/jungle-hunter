//
//  CameraViewController.swift
//  jungle-hunter-app
//
//  Created by Sonja Cao on 28.02.20.
//  Copyright © 2020 htl-leonding. All rights reserved.
//

import UIKit

class CameraViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBAction func retakePhoto(_ sender: Any) {
        openCamera()
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
