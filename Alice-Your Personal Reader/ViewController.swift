//
//  ViewController.swift
//  Alice-Your Personal Reader
//
//  Created by Arafat Chowdhury on 2/2/19.
//  Copyright © 2019 Ashik Chowdhury. All rights reserved.
//

import UIKit
import Firebase
import FirebaseMLVision
import Vision


class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet weak var imageView: UIImageView!
    
    var textRecognizer: VisionTextRecognizer!
    
    let imagePicker = UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let vision = Vision.vision()
        textRecognizer = vision.onDeviceTextRecognizer()
        
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = false
        
    }
 
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let userPickedImage  = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = userPickedImage
            let pickedImage = VisionImage(image: userPickedImage)
            textRecognizer.process(pickedImage) { (features, error) in
                self.processResults(from: features, error: error)
            }
            
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    

    
    
    func processResults(from text: VisionText?, error: Error?){
        guard let features = text, let _ = imageView.image else {return}
        
        let resultText = features.text
//        for block in features.blocks {
//            for line in block.lines {
//                for element in line.elements {
                    print(resultText)
//                }
//            }
//        }
        
    }
   
//    func runTextRecognition(with image: UIImage) {
//        let image = VisionImage(image: image)
//        textRecognizer.process(image) { (features, error) in
//            self.processResults(from: features, error: error)
//        }
//    }
    
    
    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
        present(imagePicker, animated: true, completion: nil)
    }
    
}
