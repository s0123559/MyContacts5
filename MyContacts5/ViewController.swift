//
//  ViewController.swift
//  MyContacts5
//
//  Created by cis290 on 10/26/17.
//  Copyright © 2017 Rock Valley College. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var fullname: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phone: UITextField!
    
    @IBOutlet weak var btnSave: UIButton!
    
    @IBOutlet weak var btnEdit: UIButton!
    
    @IBOutlet weak var btnCall: UIButton!
    
    @IBOutlet weak var status: UIButton!
    

    @IBAction func btnEdit(_ sender: UIButton) {
        //0a Edit contact
        fullname.isEnabled = true
        email.isEnabled = true
        phone.isEnabled = true
        btnSave.isHidden = false
        btnEdit.isHidden = true
        fullname.becomeFirstResponder()

        
    }
    
    
    @IBAction func btnCall(_ sender: Any) {
        //0b Call Number
        
        //if number not null
        if (phone.text !=  ""){
            let formatedNumber = phone.text!.components(separatedBy: NSCharacterSet.decimalDigits.inverted).joined(separator: "")
            print("calling \(formatedNumber)")
            let phoneUrl = "tel://\(formatedNumber)"
            let url:URL = URL(string: phoneUrl)!
            UIApplication.shared.open(url)
        }

    }
    
    
    @IBAction func btnSave(_ sender: Any) {
        //1 Add Save Logic
        
        
        if (contactdb != nil)
        {
            
            contactdb.setValue(fullname.text, forKey: "fullname")
            contactdb.setValue(email.text, forKey: "email")
            contactdb.setValue(phone.text, forKey: "phone")
            
        }
        else
        {
            let entityDescription =
                NSEntityDescription.entity(forEntityName: "Contact",in: managedObjectContext)
            
            let contact = Contact(entity: entityDescription!,
                                  insertInto: managedObjectContext)
            
            contact.fullname = fullname.text!
            contact.email = email.text!
            contact.phone = phone.text!
        }
        var error: NSError?
        do {
            try managedObjectContext.save()
        } catch let error1 as NSError {
            error = error1
        }
        
        if let err = error {
            //if error occurs
            status.text = err.localizedFailureReason
        } else {
            self.dismiss(animated: false, completion: nil)
            
        }

    }
    
    
    @IBAction func btnBack(_ sender: Any) {
        //2) Dismiss ViewController
        self.dismiss(animated: false, completion: nil)
        //**End Copy**
    }
    
    //**Begin Copy**
    //3) Add ManagedObject Data Context
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //**End Copy**
    
    
    //**Begin Copy**
    //4) Add variable contactdb (used from UITableView
    var contactdb:NSManagedObject!

    }
    
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {

        super.viewDidLoad()
        //5 Add logic to load db. If contactdb has content that means a row was tapped on UiTableView
        
        
        if (contactdb != nil)
        {
            fullname.text = contactdb.value(forKey: "fullname") as? String
            email.text = contactdb.value(forKey: "email") as? String
            phone.text = contactdb.value(forKey: "phone") as? String
            btnSave.setTitle("Update", for: UIControlState())
            btnCall.isHidden = false
            btnEdit.isHidden = false
            fullname.isEnabled = false
            email.isEnabled = false
            phone.isEnabled = false
            btnSave.isHidden = true
        }else{
            btnCall.isHidden = true
            btnEdit.isHidden = true
            fullname.isEnabled = true
            email.isEnabled = true
            phone.isEnabled = true
        }
        fullname.becomeFirstResponder()
        // Do any additional setup after loading the view.
        //Looks for single or multiple taps
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.DismissKeyboard))
        //Adds tap gesture to view
        view.addGestureRecognizer(tap)
        
        
        // Do any additional setup after loading the view, typically from a nib.
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
//6 Add to hide keyboard

override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesBegan(touches , with:event)
    if (touches.first as UITouch!) != nil {
        DismissKeyboard()
    }
    //7 Add to hide keyboard
    
    func DismissKeyboard(){
        //forces resign first responder and hides keyboard
        fullname.endEditing(true)
        email.endEditing(true)
        phone.endEditing(true)
        
    }
    //8 Add to hide keyboard
    
    func textFieldShouldReturn(_ textField: UITextField!) -> Bool     {
        textField.resignFirstResponder()
        return true;
    }






}

