//
//  LoginViewController.swift
//  Benevits
//
//  Created by Fer on 25/03/22.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate  {
    
    var networkManager : LoginInteractor?
    
    lazy var imageViewFond : UIImageView = {
       let img = UIImageView()
        img.image = UIImage(named: "fondo")
        return img
    }()
    
    lazy var imageView : UIImageView = {
       let img = UIImageView()
        img.image = UIImage(named: "familia")
        return img
    }()
    
    lazy var imageViewLogo : UIImageView = {
       let img = UIImageView()
        img.image = UIImage(named: "logo")
        img.tintColor = .white
        return img
    }()
    
    lazy var textFieldUser : UITextField = {
       let textField = UITextField()
        textField.textColor = .black
        textField.placeholder = "Correo"
        textField.backgroundColor = .white
        textField.delegate = self
        textField.keyboardType = .emailAddress
        return textField
    }()
    
    lazy var textFieldPassword : UITextField = {
       let textField = UITextField()
        textField.textColor = .black
        textField.placeholder = "Contraseña"
        textField.backgroundColor = .white
        textField.delegate = self
        textField.isSecureTextEntry = true
        return textField
    }()
    
    lazy var viewDownUser : UIView = {
       let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    lazy var viewDownPassword : UIView = {
       let view = UIView()
       view.backgroundColor = .gray
        return view
    }()
    
    lazy var buttonPasswordRecov : UIButton = {
       let button = UIButton()
        button.setTitle("¿Olvidaste tu contraseña?", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        return button
    }()
    
    lazy var viewDownPassworRecov : UIView = {
       let view = UIView()
       view.backgroundColor = .gray
        return view
    }()
    
    lazy var buttonLogin : UIButton = {
       let button = UIButton()
        button.setTitle("Entrar", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .gray
        button.layer.cornerRadius = 10
        button.isEnabled = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.hidesBackButton = true
        initUI()
        initInteractor()
    }
    
    func initInteractor(){
        
        networkManager = LoginInteractor()
        networkManager?.delegate = self
    }
    
    func initUI(){
        
        textFieldUser.text = "prueba@nextia.mx"
        textFieldPassword.text = "PruebaNextia2021"
  
        view.addSubview(imageViewFond)
        view.addSubview(imageView)
        view.addSubview(imageViewLogo)
        view.addSubview(textFieldUser)
        view.addSubview(textFieldPassword)
        view.addSubview(viewDownUser)
        view.addSubview(viewDownPassword)
        view.addSubview(buttonPasswordRecov)
        view.addSubview(viewDownPassworRecov)
        view.addSubview(buttonLogin)
        
        
        imageViewFond.addAnchorsAndSize(width: nil, height: height / 2 - 20, left: 0, top: 0, right: 0, bottom: nil)
        imageView.addAnchorsAndCenter(centerX: true, centerY: false, width: nil, height: height / 7, left: 100, top: height / 15, right: 100, bottom: nil)
        imageViewLogo.addAnchorsAndCenter(centerX: true, centerY: false, width: nil, height: 50, left: 50, top: 20, right: 50, bottom: nil,withAnchor: .top,relativeToView: imageView)
        textFieldUser.addAnchorsAndSize(width: nil, height: height / 20, left: 30, top: 5, right: 30, bottom: nil, withAnchor: .top, relativeToView: imageViewFond)
        viewDownUser.addAnchorsAndSize(width: nil, height: 1, left: 30, top: 0, right: 30, bottom: nil,withAnchor: .top,relativeToView: textFieldUser)
        textFieldPassword.addAnchorsAndSize(width: nil, height: height / 20, left: 30, top: 20, right: 30, bottom: nil, withAnchor: .top, relativeToView: viewDownUser)
        viewDownPassword.addAnchorsAndSize(width: nil, height: 1, left: 30, top: 0, right: 30, bottom: nil,withAnchor: .top,relativeToView: textFieldPassword)
        buttonPasswordRecov.addAnchors(left: height / 4 + 30, top: 10, right: 30, bottom: nil, withAnchor: .top, relativeToView: viewDownPassword)
        viewDownPassworRecov.addAnchorsAndSize(width: nil, height: 1, left: height / 4 + 30, top: -10, right: 30, bottom: nil, withAnchor: .top, relativeToView: buttonPasswordRecov)
        buttonLogin.addAnchorsAndSize(width: nil, height: 40, left: 30, top: 30, right: 30, bottom: nil, withAnchor: .top, relativeToView: viewDownPassworRecov)
        
        buttonLogin.addTarget(self, action: #selector(confirmLogin), for: .touchUpInside)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
      
        if textFieldUser.text!.count > 1 && textFieldPassword.text!.count > 1{
            buttonLogin.isEnabled = true
            buttonLogin.backgroundColor = redColor
     }else{
         buttonLogin.isEnabled = false
         buttonLogin.backgroundColor = .gray
     }
        return true
    }
    
    @objc func confirmLogin(){
        
      let passwordString = textFieldPassword.text ?? ""
      let userEmail = textFieldUser.text ?? ""
       networkManager?.login(userString: userEmail, passwordString: passwordString)

    }
}

extension LoginViewController : loginDelegate{
    func loginok() {
        let vc = HomeViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func loginfail() {
        let alert: UIAlertController
        alert = UIAlertController(title: "Error", message: "Usuaro o password incorrecto", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
        self.present(alert, animated: true)
    }
    
    
}
