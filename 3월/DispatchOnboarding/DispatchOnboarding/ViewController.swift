//
//  ViewController.swift
//  DispatchOnboarding
//
//  Created by 안종표 on 2023/03/18.
//

import UIKit

final class ViewController: UIViewController {
    private lazy var verticalStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 16
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
        let action = UIAction {[weak self] _ in
            self?.fetchAllImages()
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
    }

    func configureUI(){
        self.view.backgroundColor = .white
        for i in 0..<5{
            lazy var lusterStackView: LusterView = {
                let stackView = LusterView(tagNum: i)
                stackView.translatesAutoresizingMaskIntoConstraints = false
                return stackView
            }()
            self.verticalStackView.addArrangedSubview(lusterStackView)
        }
        
        self.verticalStackView.addArrangedSubview(loadAllButton)
        self.view.addSubview(self.verticalStackView)
        self.verticalStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        self.verticalStackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        self.verticalStackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
    }
    
    func fetchAllImages(){
        var count = 0
        self.verticalStackView.subviews.forEach { lusterView in
            guard let lusterView = lusterView as? LusterView else{return}
            lusterView.reset()
            lusterView.fetchImage(count)
            count += 1
        }
    }
}


