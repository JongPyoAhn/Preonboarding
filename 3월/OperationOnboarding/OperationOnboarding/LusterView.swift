//
//  LusterView.swift
//  OperationOnboarding
//
//  Created by 안종표 on 2023/03/28.
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
    private var task: URLSessionDataTask!
    private var observation: NSKeyValueObservation!
    private var workItem: DispatchWorkItem!
    
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
        progressView.progress = 0
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
            
            button.isSelected = !button.isSelected
            
            guard button.isSelected else{
//                self?.task.cancel()
                self?.workItem.cancel()
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

    deinit{
        observation.invalidate()
        observation = nil
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
        workItem = DispatchWorkItem{
            guard self.workItem.isCancelled == false else {
                self.reset()
                return
            }
            let url = ImageURL[tagNum]
            let request = URLRequest(url: url)
            self.task = URLSession.shared.dataTask(with: request) { data, resopnse, error in
                if let error = error{
                    guard error.localizedDescription == "cancelled" else{
                        fatalError(error.localizedDescription)
                    }
                    
                }
                
                guard self.workItem.isCancelled == false else {
                    self.reset()
                    return
                }
                
                guard let data = data, let image = UIImage(data: data) else {
                    DispatchQueue.main.async {
                        self.imageView.image = .init(systemName: "xmark")
                    }
                    return
                }
                
                guard self.workItem.isCancelled == false else {
                    self.reset()
                    return
                }
                
                DispatchQueue.main.async {
                    self.imageView.image = image
                    self.button.isSelected = false
                }
            }
            
            self.observation = self.task.progress.observe(\.fractionCompleted, options: [.new], changeHandler: { progress, change in
                DispatchQueue.main.async {
                    self.progressView.progress = Float(progress.fractionCompleted)
                }
            })
            
            self.task.resume()
        }
        workItem.perform()
    }
    func reset(){
        DispatchQueue.main.async {
            self.imageView.image = .init(systemName: "photo")
            self.progressView.progress = 0
        }
        
    }
}
