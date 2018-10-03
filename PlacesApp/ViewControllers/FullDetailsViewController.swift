//
//  FullDetailsViewController.swift
//  PlacesApp
//
//  Created by Sumit Ghosh on 01/10/18.
//  Copyright © 2018 Sumit Ghosh. All rights reserved.
//

import UIKit

class FullDetailsViewController: UIViewController {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var voteCountLabel: UILabel!
    @IBOutlet weak var rateCountLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    
    var data:mainData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.AddDataToUI()
    }
    
    func AddDataToUI() -> Void {
        self.posterImageView.imageFromServerURL(urlString: "\(NetworkConfiguration.IMAGE_BASE_URL)\(data.backdrop_path ?? "")")
        movieTitleLabel.text = self.data.original_title ?? ""
        voteCountLabel.text = "\(self.data.vote_count ?? 0)"
        rateCountLabel.text = "\(self.data.vote_average ?? 0)"
        descriptionLabel.text = self.data.overview ?? ""
        releaseDateLabel.text = self.data.release_date ?? ""
        languageLabel.text = self.data.original_language ?? ""
    }
    @IBAction func closeAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
