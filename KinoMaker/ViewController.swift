//
//  ViewController.swift
//  KinoMaker
//
//  Created by Maksim Makarevich on 7.09.23.
//

import UIKit

final class ViewController: UIViewController {

    private let repository = Repository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        getServiceStatus()
        getRandomFilm()
    }

}

// MARK: - Private functions

private extension ViewController {
    
    func getServiceStatus() {
        repository.getServiceStatus { result in
            RequestTracker.shared.trackRequest()
            
            switch result {
            case .success(let success):
                print(success)
            case .failure(let failure):
                print("error getServiceStatus: \(failure.localizedDescription)")
            }
        }
    }
    
    func getRandomFilm() {
        repository.getRandomFilm { result in
            RequestTracker.shared.trackRequest()
            
            switch result {
            case .success(let success):
                print(success)
            case .failure(let failure):
                print("error getRandomFilm: \(failure.localizedDescription)")
            }
        }
    }
    
}
