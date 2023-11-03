//
//  UserSelectionViewController.swift
//  KinoMaker
//
//  Created by Maksim Makarevich on 3.11.23.
//

import SnapKit
import UIKit

final class UserSelectionViewController: UIViewController {

    
    
    // MARK: - UI
    
    private let firstUserButton: AnimateButton = {
        let button = AnimateButton(type: .system)
        button.setTitle("First User", for: .normal)
        button.isDisabled = false
        return button
    }()
    
    private let secondUserButton: AnimateButton = {
        let button = AnimateButton(type: .system)
        button.setTitle("Second User", for: .normal)
        button.isDisabled = false
        return button
    }()
    
    // MARK: - Initialize
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Livecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Выберите пользователя"
        setupLayout()
        addTarget()
    }
    
}

// MARK: - Private functions

private extension UserSelectionViewController {
    
    func setupLayout() {
        view.addSubview(firstUserButton)
        [firstUserButton, secondUserButton].forEach { view.addSubview($0) }
   
        firstUserButton.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(100)
            $0.height.equalTo(40)
        }
        
        secondUserButton.snp.makeConstraints {
            $0.top.equalTo(firstUserButton.snp.bottom).offset(40)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(100)
            $0.height.equalTo(40)
        }
    }
    
    func addTarget() {
        firstUserButton.addTarget(self, action: #selector(selectedFirstUser), for: .touchUpInside)
        secondUserButton.addTarget(self, action: #selector(selectedSecondUser), for: .touchUpInside)
    }
    
    @objc
    func selectedFirstUser() {
        let viewModel = MovieSelectionViewModel()
        let vc = MovieSelectionViewController(viewModel: viewModel, user: .firstUser)
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc
    func selectedSecondUser() {
        let viewModel = MovieSelectionViewModel()
        let vc = MovieSelectionViewController(viewModel: viewModel, user: .secondUser)
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
