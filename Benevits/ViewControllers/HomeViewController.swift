//
//  HomeViewController.swift
//  Benevits
//
//  Created by Fer on 26/03/22.
//

import UIKit
import SideMenu
import SkeletonView

class HomeViewController: UIViewController {
  
    
    var charInt : CharInteractor?
    var dataSource : ChartObject?
   
    var menu : SideMenuNavigationController?
    
    var images = ["infonavit"]
   
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 20
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.isPagingEnabled = false
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(ItemsCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        initUI()
        initInteractor()
        
        menu =  SideMenuNavigationController(rootViewController: MenuTableViewController())
        menu?.leftSide = true
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
        SideMenuManager.default.leftMenuNavigationController = menu
        
        self.menu?.setNavigationBarHidden(false, animated: true)
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = redColor
        self.navigationController?.navigationBar.standardAppearance = appearance;
        self.navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
      
        let leftBarButton = UIBarButtonItem(image: UIImage(named: "menu"), style: .plain, target: self, action: #selector(addTapped))
        self.navigationItem.leftBarButtonItem = leftBarButton
        self.navigationItem.leftBarButtonItem?.tintColor = .white
        self.navigationController?.navigationBar.barTintColor = redColor
        
        let imageView = UIImageView(image: UIImage(named: "logo"))
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        self.navigationItem.titleView = imageView
        
        
        self.collectionView.isSkeletonable = true
        self.collectionView.showAnimatedGradientSkeleton()
        DispatchQueue.main.asyncAfter(deadline: .now() + 10, execute: {
           
            self.collectionView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
            self.collectionView.reloadData()

        }
        )
        
    }
    
    func initInteractor(){
        charInt = CharInteractor()
        charInt?.delegate = self
        charInt?.getGraphics()
    }
    
    @objc func addTapped(){
        present(menu!, animated: true)
        
    }
    
    func initUI(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        view.addSubview(collectionView)
        collectionView.addAnchorsAndSize(width: 200, height: height, left: 20, top: 50, right: 20, bottom: nil)
    }
    
}

extension HomeViewController:  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,SkeletonCollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      
        return dataSource?.count ?? 0
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier{
        
        return "cell"
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ItemsCollectionViewCell
       
        let dato = dataSource![indexPath.item]
        let ima = images[0]
        cell.imagesView.image = UIImage(named: ima )
        cell.textLabel.text = dato.display_text ?? ""

        return cell
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = UIScreen.main.bounds.width
    return CGSize(width: width / 2 - 30, height: 200)
     
     }
        
    }
    
extension HomeViewController : InteractorDelegate  {
    func responseData(response: ChartObject) {
        print(response)
        dataSource = response
        collectionView.reloadData()
    }
}


