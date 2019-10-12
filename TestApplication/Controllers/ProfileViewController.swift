//
//  ProfileViewController.swift
//  TestApplication
//
//  Created by Tharindu Ketipearachchi on 10/8/19.
//  Copyright © 2019 Tharindu Ketipearachchi. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtCountry: UITextField!
    @IBOutlet weak var txtAge: UITextField!
    @IBOutlet weak var btnRegister: UIButton!
    @IBOutlet weak var btnSave: UIButton!
    
    var isEdit:Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isEdit = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI()
    }
    
    func configureUI() {
        
        self.navigationController?.navigationBar.topItem?.title = "Profile"
        
        if Utilities.userData().validity! {
            self.btnRegister.isHidden = true
            self.btnRegister.isEnabled = false
            self.btnSave.isHidden = false
            self.btnSave.isEnabled = true
            handleEditSave()
        } else {
            self.btnRegister.isHidden = false
            self.btnRegister.isEnabled = true
            self.btnSave.isHidden = true
            self.btnSave.isEnabled = false
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    @IBAction func didTapRegister(_ sender: Any) {
        begingValidation(type: "reg")
    }
    
    @IBAction func didTapSave(_ sender: Any) {
        isEdit = !isEdit!
        if !isEdit! {
            begingValidation(type: "update")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.handleEditSave()
        }
    }
    
    func begingValidation(type:String) {
        
        if txtName.text!.isEmpty {
            Utilities.AlertWithOkAction(view: self, title: "Error", message: "Enter name!")
        } else if txtUsername.text!.isEmpty {
            Utilities.AlertWithOkAction(view: self, title: "Error", message: "Enter username!")
        } else if txtCountry.text!.isEmpty {
           Utilities.AlertWithOkAction(view: self, title: "Error", message: "Enter country name!")
        } else if txtAge.text!.isEmpty {
            Utilities.AlertWithOkAction(view: self, title: "Error", message: "Enter age!")
        } else {
            if type == "reg" {
                register()
            } else if type == "update" {
                update()
            }
        }
    }
    
    func register() {
        let user = User(name: txtName.text!, usernme: txtUsername.text! , country: txtCountry.text!, age: txtAge.text!)
        Utilities.saveUserData(user: user)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.configureUI()
        }
    }
    
    func update() {
        let user = User(name: txtName.text!, usernme: txtUsername.text! , country: txtCountry.text!, age: txtAge.text!)
        Utilities.saveUserData(user: user)
    }
    
    func handleEditSave() {
        if isEdit! {
            //Editable Mood
            btnSave.setTitle("Save",for: .normal)
            let user = Utilities.userData()
            txtName.placeholder = user.name
            txtUsername.placeholder = user.username
            txtCountry.placeholder = user.country
            txtAge.placeholder = user.age
            txtName.isUserInteractionEnabled = true
            txtUsername.isUserInteractionEnabled = true
            txtAge.isUserInteractionEnabled = true
            txtCountry.isUserInteractionEnabled = true
        } else {
            //Uneditable Mood
            btnSave.setTitle("Edit",for: .normal)
            let user = Utilities.userData()
            txtName.text = user.name
            txtUsername.text = user.username
            txtCountry.text = user.country
            txtAge.text = user.age
            txtName.isUserInteractionEnabled = false
            txtUsername.isUserInteractionEnabled = false
            txtAge.isUserInteractionEnabled = false
            txtCountry.isUserInteractionEnabled = false
        }
    }
}

extension ProfileViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
