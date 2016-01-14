//
//  CreateColorViewController.swift
//  Friends
//
//  Created by Nivardo Ibarra on 12/27/15.
//  Copyright © 2015 Nivardo Ibarra. All rights reserved.
//

import UIKit

protocol CreateColorViewControllerDelegate {
    func createColor(name: String, color: UIColor)
}

class CreateColorViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var txtfColor: UITextField!
    var delegate: CreateColorViewControllerDelegate?
    weak var selectedButton: UIButton?

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

    @IBAction func colorSelected(sender: UIButton) {
        if selectedButton != nil {
            selectedButton?.layer.borderColor = nil
            selectedButton?.layer.borderWidth = 0.0
        }
        sender.layer.borderColor = UIColor.blackColor().CGColor
        sender.layer.borderWidth = 5.0
        selectedButton = sender
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
    @IBAction func save(sender: UIBarButtonItem) {
        let name = txtfColor.text!
        var colorCG: CGColor?
        colorCG = selectedButton?.layer.backgroundColor
        
        if colorCG != nil {
            let color =  UIColor(CGColor: colorCG!)
            if name.isEmpty {
                showAlertMessage("Wait!!!", message: "Put a name", owner: self)
            }else {
                if delegate != nil {
                    delegate?.createColor(name, color: color)
                    navigationController?.popViewControllerAnimated(true)
                }
            }
        }else {
            showAlertMessage("Wait!!!", message: "Select a Color and put a Name", owner: self)
        }
    }
    
    func showAlertMessage (title: String, message: String, owner:UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.ActionSheet)
        alert.addAction(UIAlertAction(title: "Accept", style: UIAlertActionStyle.Default, handler:{ (ACTION :UIAlertAction!)in
        }))
        self.presentViewController(alert, animated: true, completion: nil)
    }

}
