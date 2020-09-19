//
//  GridDetailsController.swift
//  Flix
//
//  Created by Laura Baker on 9/18/20.
//  Copyright © 2020 Kevin Baker. All rights reserved.
//

import UIKit
import AlamofireImage

class GridDetailsController: UIViewController {

    @IBOutlet weak var gridBackdropView: UIImageView!
    @IBOutlet weak var gridPosterView: UIImageView!
    @IBOutlet weak var gridTitleLabel: UILabel!
    @IBOutlet weak var gridSynopsisLabel: UILabel!
    
    var movie: [String:Any]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        gridTitleLabel.text = movie["title"] as? String
        gridSynopsisLabel.text = movie["overview"] as? String
        gridSynopsisLabel.sizeToFit()
        
        let baseURL = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterURL = URL(string: baseURL + posterPath)
        
        gridPosterView.af.setImage(withURL: posterURL!)
        
        let backdropath = movie["backdrop_path"] as! String
        let backdropURL = URL(string: "https://image.tmdb.org/t/p/w780" + backdropath)
        
        gridBackdropView.af.setImage(withURL: backdropURL!)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        print("Loading up grid details screen..")
    }
    
     */
}
