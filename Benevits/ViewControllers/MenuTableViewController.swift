//
//  MenuTableViewController.swift
//  Benevits
//
//  Created by Fer on 26/03/22.
//

import UIKit



class MenuTableViewController: UITableViewController {
    
    var items = ["Benevits"]
    
    lazy var buttonSiginOf : UIButton = {
       let button = UIButton()
        button.setTitle("Cerrar Sesion", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = redColor
        navigationItem.hidesBackButton = true
      
        let imageView = UIImageView(image: UIImage(named: "logo"))
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        self.navigationItem.titleView = imageView
        initUI()
    }
    
    func initUI(){
        view.addSubview(buttonSiginOf)
        buttonSiginOf.addAnchorsAndSize(width: nil, height: 50, left: 20, top: height / 1 - 150, right: 20, bottom: 20)
        buttonSiginOf.addTarget(self, action: #selector(siginOf), for: .touchUpInside)
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
    
    @objc func siginOf(){
        
        let alert = UIAlertController(title: "¿Cerrar Sesion?", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Si", style: .default, handler: { ACTION in
            
            let vc = LoginViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
   
    }

 

}
