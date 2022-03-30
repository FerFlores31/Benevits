//
//  WelcomeViewController.swift
//  Benevits
//
//  Created by Fer on 25/03/22.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    lazy var imageView : UIImageView = {
       let img = UIImageView()
        img.image = UIImage(named: "logo")
        img.tintColor = .white
        img.alpha = 0
        img.fadeIn()
        return img
    }()
    
    
    lazy var activeIndicator : UIActivityIndicatorView = {
        let act = UIActivityIndicatorView(style: .large)
        act.color = .black
        act.center = view.center
        return act
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        view.backgroundColor = redColor
        activityIndicator()
    }
    
    func activityIndicator(){
        view.backgroundColor = redColor
        view.alpha = 0.5
        view.addSubview(activeIndicator)
        activeIndicator.startAnimating()
        Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(nextView2), userInfo: nil, repeats: false)
    }
    
    func initUI(){
        activeIndicator.stopAnimating()
        view.backgroundColor = redColor
        view.alpha = 1
        Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(nextView), userInfo: nil, repeats: false)
        view.addSubview(imageView)
        imageView.addAnchorsAndCenter(centerX: true, centerY: true, width: nil, height: 50, left: 50, top: nil, right: 50, bottom: nil)
   }
    
    @objc func nextView2(){
        initUI()
     }

   @objc func nextView(){
        let vc = LoginViewController()
     navigationController?.pushViewController(vc, animated: true)
    }
}

 extension UIView {
 func fadeIn(duration: TimeInterval = 3.0) {
     UIView.animate(withDuration: duration, animations: {
        self.alpha = 1.0
     })
 }
}
