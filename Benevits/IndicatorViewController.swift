//
//  IndicatorViewController.swift
//  Benevits
//
//  Created by Fer on 26/03/22.
//

import UIKit

class IndicatorViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
        view.backgroundColor = .white
        let activeIndicator = UIActivityIndicatorView(style: .large)
        activeIndicator.color = .black
        activeIndicator.center = self.view.center
        view.addSubview(activeIndicator)
        activeIndicator.startAnimating()
        Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(nextView), userInfo: nil, repeats: false)

    }
    
    @objc func nextView(){
         let vc = WelcomeViewController()
      navigationController?.pushViewController(vc, animated: true)
     }
    


}
