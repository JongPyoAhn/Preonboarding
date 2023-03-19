//
//  LusterView.swift
//  DispatchOnboarding
//
//  Created by 안종표 on 2023/03/18.
//

import UIKit

final class LusterView: UIStackView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()

    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI(){
        self.axis = .vertical
        self.alignment = .fill
        self.distribution = .fill
        self.spacing = 16
        self.translatesAutoresizingMaskIntoConstraints = false
        
        makeStackView().forEach{ stackview in
            addArrangedSubview(stackview)
            let imageView = makeImageView()
            let progressView = makeProgressView()
            let loadButton = makeLoadButton()
            [imageView, progressView, loadButton].forEach { subview in
                stackview.addArrangedSubview(subview)
            }
            imageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25).isActive = true
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 1.0).isActive = true
        }
    }
    
    func makeStackView() -> [UIStackView]{
        var stackViewArray = [UIStackView]()
        for _ in 0..<5{
            let stackview = UIStackView()
            stackview.axis = .horizontal
            stackview.alignment = .center
            stackview.distribution = .fill
            stackview.spacing = 13
            stackview.translatesAutoresizingMaskIntoConstraints = false
            stackViewArray.append(stackview)
        }
        return stackViewArray
    }
    
    func makeImageView() -> UIImageView {
        lazy var imageView: UIImageView = {
            let imageView = UIImageView()
            imageView.image = UIImage(systemName: "photo")
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
        return imageView
    }
    
    func makeProgressView() -> UIProgressView {
        lazy var progressView: UIProgressView = {
            let progressView = UIProgressView()
            progressView.progress = 0.5
            progressView.translatesAutoresizingMaskIntoConstraints = false
            return progressView
        }()
        return progressView
    }
    
    func makeLoadButton() -> UIButton {
        lazy var loadButton: UIButton = {
            let button = UIButton()
            let configuration = UIButton.Configuration.filled()
            button.setTitle("Load", for: .normal)
            button.setTitle("Cancel", for: .selected)
            button.titleLabel?.textAlignment = .center
            button.translatesAutoresizingMaskIntoConstraints = false
            button.configuration = configuration
            return button
        }()
        return loadButton
    }
}
