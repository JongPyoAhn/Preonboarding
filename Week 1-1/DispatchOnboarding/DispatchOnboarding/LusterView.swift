//
//  LusterView.swift
//  DispatchOnboarding
//
//  Created by 안종표 on 2023/03/18.
//


import UIKit

final class LusterView: UIStackView {
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var progressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.progress = 0.5
        progressView.translatesAutoresizingMaskIntoConstraints = false
        return progressView
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        let configuration = UIButton.Configuration.filled()
        button.setTitle("Load", for: .normal)
        button.setTitle("Cancel", for: .selected)
        button.titleLabel?.textAlignment = .center
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = configuration
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI(){
        self.axis = .horizontal
        self.alignment = .center
        self.distribution = .fill
        self.spacing = 13
        self.translatesAutoresizingMaskIntoConstraints = false
        
        [self.imageView, self.progressView, self.button].forEach{
            self.addArrangedSubview($0)
        }
        self.imageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25).isActive = true
        self.imageView.widthAnchor.constraint(equalTo: self.imageView.heightAnchor, multiplier: 1).isActive = true
    }
}
