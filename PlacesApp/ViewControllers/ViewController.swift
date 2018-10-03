//
//  ViewController.swift
//  PlacesApp
//
//  Created by Sumit Ghosh on 28/09/18.
//  Copyright © 2018 Sumit Ghosh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var placeCollectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var dataArray = [mainData]()
    var openCellIndex:Int! = 0
    var isOpen:Bool! = false
    var sendingData:mainData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        placeCollectionView.register(UINib(nibName: "PlaceCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "placeCell")
        placeCollectionView.delegate = self
        placeCollectionView.dataSource = self
        self.getData()
    }
    
    func getData() -> Void {
        activityIndicator.startAnimating()
        APIHelper.sharedInstance.getPlaceData { (response, error) in
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
                
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
                
                if(error == nil) {
                    self.dataArray = response?.results ?? []
                    self.backgroundImageView.imageFromServerURL(urlString: "\(NetworkConfiguration.IMAGE_BASE_URL)\(self.dataArray[0].backdrop_path ?? "")")
                    self.placeCollectionView.reloadData()
                }else{
                    print(error as Any)
                }
                
            })
        }
    }
    
    // Make the Status Bar Light/Dark Content for this View
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
        //return UIStatusBarStyle.default   // Make dark again
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func openDetailsScreen(sender:UIButton) {
            sendingData = self.dataArray[sender.tag]
            sender.removeFromSuperview()
            self.performSegue(withIdentifier: "alldetails", sender: sendingData)
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "alldetails" {
            let parentView:FullDetailsViewController = segue.destination as! FullDetailsViewController
            parentView.transitioningDelegate = self
            parentView.data = sender as! mainData
        }
    }
}
extension ViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    //MARK: collection view delegates
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (isOpen == true) {
            for cell in self.placeCollectionView .visibleCells {
                let indexPath = self.placeCollectionView.indexPath(for: cell)
                if (indexPath?.row == self.openCellIndex) {
                    let collectionCell:PlaceCollectionViewCell = cell as! PlaceCollectionViewCell
                    collectionCell.animateCloseCell()
                    self.isOpen = false
                    self.openCellIndex = 0
                }
            }
        }else{
            self.openCellIndex = indexPath.row
            self.isOpen = true
            collectionView.reloadData()
        }
    }
    
    //MARK: collection view datasource
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:PlaceCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "placeCell", for: indexPath) as! PlaceCollectionViewCell
        
        let data = self.dataArray[indexPath.row]
        cell.placeLabel.text = data.title ?? ""
        cell.placeImageView.imageFromServerURL(urlString: "\(NetworkConfiguration.IMAGE_BASE_URL)\(data.poster_path ?? "")")
        cell.voteCountLabel.text = "\(data.vote_count ?? 0)"
        cell.ratingCountLabel.text = "\(data.vote_average ?? 0.0)"
        let button = UIButton.init()
        if self.isOpen == true {
            if self.openCellIndex == indexPath.row {
                cell.animateCellOpen()
                button.frame = CGRect(x: 0, y: 0, width: cell.photoView.frame.size.width, height: cell.photoView.frame.size.height)
                button.backgroundColor = UIColor.clear
                button.tag = indexPath.row
                button.addTarget(self, action: #selector(openDetailsScreen(sender:)), for: UIControlEvents.touchUpInside)
                cell.photoView .addSubview(button)
            } else {
                button.removeFromSuperview()
            }
        } else {
            button.removeFromSuperview()
        }
        
        if self.isOpen == false {
            cell.ratingCountLabelView.isHidden = true
            cell.RatingLabelsView.isHidden = true
            cell.detailsViewBottomConstraint.constant = 50
            cell.detailsViewLeadingConstraint.constant = 25
            cell.detailsViewTrailingConstraint.constant = 25
            cell.contentView.layoutIfNeeded()
            button.removeFromSuperview()
        }
        cell.photoView.dropShadow()

        return cell
    }
    
    //MARK: Collection View Flow layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.placeCollectionView.frame.size.width - 0 , height: self.placeCollectionView.frame.size.width + 50);
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        for cell in self.placeCollectionView .visibleCells {
            let indexPath = self.placeCollectionView.indexPath(for: cell)
            let data = self.dataArray[(indexPath?.row)!]
            self.backgroundImageView.imageFromServerURL(urlString: "\(NetworkConfiguration.IMAGE_BASE_URL)\(data.backdrop_path ?? "")")
        }
    }
}

extension ViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController)
        -> UIViewControllerAnimatedTransitioning? {
            let cell:PlaceCollectionViewCell = self.placeCollectionView.visibleCells[0] as! PlaceCollectionViewCell
            let width = self.view.frame.size.width
            let height = self.view.frame.size.height
            return FlipPresentAnimationController(originFrame: CGRect(x:(width/2 - cell.photoView.frame.size.width/2)  , y: (height/2 - cell.photoView.frame.size.height/2), width: cell.photoView.frame.size.width, height: cell.photoView.frame.size.height))
    }
    
    func animationController(forDismissed dismissed: UIViewController)
        -> UIViewControllerAnimatedTransitioning? {
            guard let _ = dismissed as? FullDetailsViewController else {
                return nil
            }
            let cell:PlaceCollectionViewCell = self.placeCollectionView.visibleCells[0] as! PlaceCollectionViewCell
            let width = self.view.frame.size.width
            let height = self.view.frame.size.height
            
            return FlipDismissAnimationController(destinationFrame: CGRect(x:(width/2 - cell.photoView.frame.size.width/2)  , y: (height/2 - cell.photoView.frame.size.height/2), width: cell.photoView.frame.size.width, height: cell.photoView.frame.size.height))
    }
    
}

