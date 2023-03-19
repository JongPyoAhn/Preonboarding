//
//  ViewController.swift
//  DispatchOnboarding
//
//  Created by 안종표 on 2023/03/18.
//

import UIKit

final class ViewController: UIViewController {
    private lazy var lusterStackView: LusterView = {
        var stackView = LusterView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var loadAllButton: UIButton = {
        var button = UIButton()
        let configuration = UIButton.Configuration.filled()
        button.configuration = configuration
        button.setTitle("LoadAll", for: .normal)
        button.setTitle("Cancel", for: .selected)
        button.titleLabel?.textAlignment = .center
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
    }

    func configureUI(){
        self.view.backgroundColor = .white
        self.lusterStackView.addArrangedSubview(loadAllButton)
        self.view.addSubview(lusterStackView)
        self.lusterStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        self.lusterStackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        self.lusterStackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true

    }
    
    
}


