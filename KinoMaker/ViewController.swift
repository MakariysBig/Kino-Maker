//
//  ViewController.swift
//  KinoMaker
//
//  Created by Maksim Makarevich on 7.09.23.
//

import UIKit

class ViewController: UIViewController {

    let repository = Repository()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        repository.getServiceStatus { result in
            RequestTracker.shared.trackRequest()
            
            switch result {
            case .success(let success):
                print(success)
            case .failure(let failure):
                print("error getFilms: \(failure.localizedDescription)")
            }
        }
        
        
        
    }


}

