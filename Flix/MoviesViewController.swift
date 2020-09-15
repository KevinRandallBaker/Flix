//
//  MoviesViewController.swift
//  Flix
//
//  Created by Laura Baker on 9/15/20.
//  Copyright © 2020 Kevin Baker. All rights reserved.
//

import UIKit
import AlamofireImage

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    //IMPORTANT TABLE RECIPE
    // 1: Add UITableViewDataSource and UITableViewDelegate
    //  : Use fix to add stubs (required functions)
    // 2: Implement the required functions
    // 3: add tableView.dataSource = self
    //        tableView.delegate = self
    // 4: Ensure required functions gets data from your list such as movies
    // 5: add self.tableView.reloadData() to make sure it reloads this data as needed
    
    @IBOutlet weak var tableView: UITableView!
    
    // Create an array of dictionary
    var movies = [[String:Any]]()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        // Do any additional setup after loading the view.
        print("hello")
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
           // This will run when the network request returns
           if let error = error {
              print(error.localizedDescription)
           } else if let data = data {
              let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]

            // Requires results to be cast to an array of dictionaries
            self.movies = dataDictionary["results"] as! [[String:Any]]
            
            self.tableView.reloadData()
            
            print(dataDictionary)
              // TODO: Get the array of movies
              // TODO: Store the movies in a property to use elsewhere
              // TODO: Reload your table view data

           }
        }
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell") as! MovieTableViewCell
        
        let movie = movies[indexPath.row]
        let title = movie["title"] as! String
        let synopsis = movie["overview"] as! String
        
        cell.titleLabel?.text = title
        cell.synopsisLabel.text = synopsis
        
        let baseURL = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterURL = URL(string: baseURL + posterPath)
        
        cell.posterView.af_setImage(withURL: posterURL!)
        
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
