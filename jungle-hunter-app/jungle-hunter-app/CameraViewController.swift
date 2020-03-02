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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraVC = UIImagePickerController()
            cameraVC.delegate = self
            cameraVC.allowsEditing = false
            cameraVC.sourceType = .camera
            present(cameraVC, animated: true, completion: nil)
        } else {
            print("Currently no source type available")
        }
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
