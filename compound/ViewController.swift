//
//  ViewController.swift
//  compound
//
//  Created by Daniel Jones on 2/13/24.
//

import UIKit

class ViewController: UIViewController {
    override func loadView() {
        super.loadView()
        let compoundView = CompoundView(frame: self.view.frame)
        self.view = compoundView
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadAssets()
    }
    
    private func loadAssets() {
        Task {
            do {
                let assets = try await DataStore().fetchAssetsFromAPI()
                if let compoundView = self.view as? CompoundView {
                    compoundView.add(assets)
                    //not the best way to download images in a for loop.
                    //buit focusing time on functionality right now
                    for (index, asset) in assets.enumerated() {
                        downloadImage(from: asset.image, index: index)
                    }
                }
            } catch {
                print(error)
            }
        }
    }
    
    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    private func downloadImage(from urlStr: String, index: Int) {
        let url = URL(string: urlStr)
        print("Download Started")
        getData(from: url!) { data, response, error in
            guard let data = data, error == nil else { return }
            // always update the UI from the main thread
            DispatchQueue.main.async() { [weak self] in
                if let compoundView = self?.view as? CompoundView {
                    compoundView.assetViews[index].logoImg.image = UIImage(data: data)
                }
            }
        }
    }
}

