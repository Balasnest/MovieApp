//
//  PlaceCollectionViewCell.swift
//  PlacesApp
//
//  Created by Sumit Ghosh on 28/09/18.
//  Copyright © 2018 Sumit Ghosh. All rights reserved.
//

import UIKit

class PlaceCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cellBackgroundView: UIView!
    @IBOutlet weak var placeImageView: UIImageView!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var voteCountLabel: UILabel!
    @IBOutlet weak var ratingCountLabel: UILabel!
    @IBOutlet weak var RatingLabelsView: UIView!
    @IBOutlet weak var ratingCountLabelView: UIView!
    @IBOutlet weak var detailsViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var detailsViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var detailsViewTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var cellBackgroundLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var cellBackgroundTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var cellBackgroundBottomConstraint: NSLayoutConstraint!

    
    @IBOutlet weak var photoView: UIView!
    @IBOutlet weak var detailsView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.CustomizeView()
    }
    
    func CustomizeView() -> Void{
        self.cellBackgroundView.layer.cornerRadius = 10
        self.cellBackgroundView.layer.masksToBounds = true
        
        
    }
    
    func animateCloseCell() -> Void {
        UIView.animate(withDuration: 0.7) {
            self.ratingCountLabelView.isHidden = true
            self.RatingLabelsView.isHidden = true
            self.detailsViewBottomConstraint.constant = 50
            self.detailsViewLeadingConstraint.constant = 25
            self.detailsViewTrailingConstraint.constant = 25
            self.layoutIfNeeded()
        }
    }
    
    func animateCellOpen() -> Void {
        UIView.animate(withDuration: 0.7) {
            self.detailsViewBottomConstraint.constant = 0
            self.detailsViewLeadingConstraint.constant = 0
            self.detailsViewTrailingConstraint.constant = 0
            self.ratingCountLabelView.isHidden = false
            self.RatingLabelsView.isHidden = false
            self.layoutIfNeeded()
        }
    }
}
