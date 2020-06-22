//
//  UploadImages.swift
//  jungle-hunter-app
//
//  Created by Donnabauer C. on 26.05.20.
//  Copyright © 2020 htl-leonding. All rights reserved.
//

import UIKit

class UploadImages {
    
    static let url = URL(string: "http://localhost:3000/image")
    
    static func upload(photos: [UIImage]){
        // generate boundary string using a unique per-app string
        let boundary = UUID().uuidString
        let session = URLSession.shared

        // Set the URLRequest to POST and to the specified URL
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "POST"

        // Set Content-Type Header to multipart/form-data, this is equivalent to submitting form data with file upload in a web browser
        // And the boundary is also set here
        urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        for photo in photos {
            var data = Data()

            // Add the image data to the raw http request data
            data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
            data.append("Content-Disposition: form-data; name=\"image\"; filename=\"test.png\"\r\n".data(using: .utf8)!)
            data.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
            data.append(photo.pngData()!)

            data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)

            // Send a POST request to the URL, with the data we created earlier
            session.uploadTask(with: urlRequest, from: data, completionHandler: { responseData, response, error in
                if error == nil {
                    let jsonData = try? JSONSerialization.jsonObject(with: responseData!, options: .allowFragments)
                    if let json = jsonData as? [String: Any] {
                        print("Success: \(json)")
                        MyPhotobook.photos = [UIImage]()
                    }
                }
            }).resume()}
        }
        
}
