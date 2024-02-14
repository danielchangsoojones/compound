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
                    
                }
            } catch {
                print(error)
            }
        }
    }
}

