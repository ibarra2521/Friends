//
//  CameraViewController.swift
//  Friends
//
//  Created by Nivardo Ibarra on 12/28/15.
//  Copyright © 2015 Nivardo Ibarra. All rights reserved.
//

import UIKit
import ImageIO

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var imgvPicture: UIImageView!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblSize: UILabel!
    @IBOutlet weak var lblFor: UILabel!
    
    var imagePicker: UIImagePickerController?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func takePicture(sender: AnyObject) {
        if imagePicker == nil {
            imagePicker = UIImagePickerController()
            imagePicker?.sourceType = UIImagePickerControllerSourceType.Camera
            imagePicker?.delegate = self
        }
        
        navigationController?.presentViewController(imagePicker!, animated: true, completion: nil)
    }

    // MARK: - UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let picture = info[UIImagePickerControllerOriginalImage] as! UIImage
        let metaData = info[UIImagePickerControllerMediaMetadata] as! NSDictionary
        let exif = metaData.objectForKey(kCGImagePropertyExifDictionary) as! Dictionary<String, AnyObject>
        let date = exif[kCGImagePropertyExifDateTimeOriginal as String] as! String
        let xPixels = exif[kCGImagePropertyExifPixelXDimension as String] as! Int
        let yPixels = exif[kCGImagePropertyExifPixelYDimension as String] as! Int
        let lens = exif[kCGImagePropertyExifLensModel as String] as! String
        
        lblDate.text = date
        lblSize.text = "\(xPixels) \(yPixels)"
        lblFor.text = lens
        imgvPicture.image = picture
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}
