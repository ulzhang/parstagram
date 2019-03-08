//
//  CameraViewController.swift
//  parstagram
//
//  Created by Kevin Zhang on 3/7/19.
//  Copyright © 2019 Kevin Zhang. All rights reserved.
//

import UIKit
import AlamofireImage
import Parse

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var commentField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onCameraButton(_ sender: Any) {
        
        // easy way, not configurable
        let picker = UIImagePickerController()
        // call picker back when picture is taken
        picker.delegate = self
        // present second screen after photo is taken
        picker.allowsEditing = true
        
        // swift enum starts with .
        // if camera is available use camera, else use photo library
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        
        // show whicher source type was chosen
        present(picker, animated: true, completion: nil)
        
    }
    
    // Select image and display it
    // Need to reduce image size
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        //
        let image = info[.editedImage] as! UIImage
        
        // Core Graphics Size
        let size = CGSize(width: 300, height: 300)
        
        let scaledImage = image.af_imageScaled(to: size)
        
        imageView.image = scaledImage
        
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func onSubmitButton(_ sender: Any) {
        
        // all objects of all types inherit from PFObject
        let post = PFObject(className: "posts")
        
        post["caption"] = commentField.text
        post["author"] = PFUser.current()!
        
        let imageData = imageView.image!.pngData()
        let file = PFFileObject(data: imageData!)
        post["image"] = file
        
        
        post.saveInBackground { (success, error) in
            if success {
                self.dismiss(animated: true, completion: nil)
                print("success")
            } else {
                print("error")
            }
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
