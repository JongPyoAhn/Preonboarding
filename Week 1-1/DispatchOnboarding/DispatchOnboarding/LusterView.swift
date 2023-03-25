//
//  LusterView.swift
//  DispatchOnboarding
//
//  Created by 안종표 on 2023/03/18.
//


import UIKit
fileprivate enum ImageURL {
    private static let imageIds: [String] = [
        "europe-4k-1369012",
        "europe-4k-1318341",
        "europe-4k-1379801",
        "cool-lion-167408",
        "iron-man-323408"
    ]
    
    static subscript(index: Int) -> URL {
        let id = imageIds[index]
        return URL(string: "https://wallpaperaccess.com/download/"+id)!
    }
}

final class LusterView: UIStackView {
    private var tagNum: Int?
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        guard let tagNum = self.tagNum else {return imageView}
        imageView.tag = tagNum
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
        
        button.isSelected = true
        button.isSelected = !button.isSelected
        
        guard let tagNum = self.tagNum else {return button}
        let action = UIAction { [weak self] _ in
            guard button.isSelected else{

                return
            }
            self?.fetchImage(tagNum) }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    convenience init(tagNum: Int) {
        self.init()
        self.tagNum = tagNum
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
    
    func fetchImage(_ tagNum: Int){
        //여기서 tagNum활용해서 image바꿔주면 될듯?
        
        
    }
}
