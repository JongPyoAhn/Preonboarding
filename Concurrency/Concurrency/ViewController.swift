//
//  ViewController.swift
//  Concurrency
//
//  Created by 안종표 on 2023/03/02.
//
import Combine
import Dispatch
import UIKit

import CombineCocoa
import Kingfisher
import SnapKit


final class ViewController: UIViewController {
    private var subscription = Set<AnyCancellable>()
    private let imageStrings: [String] =
    [
        "https://picsum.photos/id/1/100/100",
        "https://picsum.photos/id/2/100/100",
        "https://picsum.photos/id/3/100/100",
        "https://picsum.photos/id/4/100/100",
        "https://picsum.photos/id/5/100/100"
    ]
    private var imageUrls: [URL] = []
    
    private lazy var verticalStackview: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 60
        return stackView
    }()
    
    private lazy var oneHorizonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var twoHorizonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var threeHorizonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var fourHorizonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()
    private lazy var fiveHorizonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var oneImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "folder")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var oneProgressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.progressViewStyle = .default
        progressView.progress = 0.5
        
        return progressView
    }()
    
    private lazy var oneLoadButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Load", for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 3
        button.titleLabel?.textColor = .white
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        return button
    }()
    
    private lazy var twoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "folder")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    private lazy var twoProgressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.progressViewStyle = .default
        progressView.progress = 0.5
        return progressView
    }()
    private lazy var twoLoadButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Load", for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 3
        button.titleLabel?.textColor = .white
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        return button
    }()
    
    private lazy var threeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "folder")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    private lazy var threeProgressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.progressViewStyle = .default
        progressView.progress = 0.5
        return progressView
    }()
    private lazy var threeLoadButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Load", for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 3
        button.titleLabel?.textColor = .white
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        return button
    }()
    
    private lazy var fourImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "folder")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    private lazy var fourProgressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.progressViewStyle = .default
        progressView.progress = 0.5
        return progressView
    }()
    private lazy var fourLoadButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Load", for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 3
        button.titleLabel?.textColor = .white
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        return button
    }()
    
    private lazy var fiveImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "folder")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    private lazy var fiveProgressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.progressViewStyle = .default
        progressView.progress = 0.5
        return progressView
    }()
    private lazy var fiveLoadButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Load", for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 3
        button.titleLabel?.textColor = .white
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        return button
    }()
    
    private lazy var allLoadButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Load All Images", for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 3
        button.titleLabel?.textColor = .white
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        
        return button
    }()
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print("viewWillLayoutSubviews")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        print("viewWillAppear")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureUI()
        self.bindUI()
    }
    func configureUI(){
        self.view.backgroundColor = .white
        [oneImageView, oneProgressView, oneLoadButton].forEach{
            
            self.oneHorizonStackView.addArrangedSubview($0)
        }
        
        [twoImageView, twoProgressView, twoLoadButton].forEach{
            self.twoHorizonStackView.addArrangedSubview($0)
        }
        
        [threeImageView, threeProgressView, threeLoadButton].forEach{
            self.threeHorizonStackView.addArrangedSubview($0)
        }
        
        [fourImageView, fourProgressView, fourLoadButton].forEach{
            self.fourHorizonStackView.addArrangedSubview($0)
        }
        
        [fiveImageView, fiveProgressView, fiveLoadButton].forEach{
            self.fiveHorizonStackView.addArrangedSubview($0)
        }
        
        [oneHorizonStackView, twoHorizonStackView, threeHorizonStackView, fourHorizonStackView, fiveHorizonStackView].forEach{
            verticalStackview.addArrangedSubview($0)
        }
        
        self.view.addSubview(verticalStackview)
        self.verticalStackview.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            $0.leading.equalToSuperview().offset(35)
            $0.trailing.equalToSuperview().offset(-35)
        }
        
        self.view.addSubview(allLoadButton)
        self.allLoadButton.snp.makeConstraints{
            $0.top.equalTo(self.verticalStackview.snp.bottom).offset(50)
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().offset(-30)
            $0.bottom.equalToSuperview().offset(-200)
        }
    }
    func bindUI(){
        self.imageStrings.forEach{
            guard let url = convertURL($0) else {return}
            imageUrls.append(url)
        }
        
        self.oneLoadButton.tapPublisher
            .sink {[weak self] _ in
                guard let self = self else{return}
                self.oneImageView.image = UIImage(systemName: "folder")
                self.imageDownload(url: self.imageUrls[0])
                    .receive(on: DispatchQueue.main)
                    .sink { completion in
                        switch completion{
                        case .finished:
                            print("성공")
                        case .failure(let err):
                            print("실패 : \(err)")
                        }
                    } receiveValue: {[weak self] image in
                        self?.oneImageView.image = image
                    }
                    .store(in: &self.subscription)

            }
            .store(in: &subscription)
        
        self.twoLoadButton.tapPublisher
            .sink {[weak self] _ in
                guard let self = self else{return}
                self.twoImageView.image = UIImage(systemName: "folder")
                self.imageDownload(url: self.imageUrls[1])
                    .receive(on: DispatchQueue.main)
                    .sink { completion in
                        switch completion{
                        case .finished:
                            print("성공")
                        case .failure(let err):
                            print("실패 : \(err)")
                        }
                    } receiveValue: {[weak self] image in
                        self?.twoImageView.image = image
                    }
                    .store(in: &self.subscription)

            }
            .store(in: &subscription)
        
        
        self.threeLoadButton.tapPublisher
            .sink {[weak self] _ in
                guard let self = self else{return}
                self.threeImageView.image = UIImage(systemName: "folder")
                self.imageDownload(url: self.imageUrls[2])
                    .receive(on: DispatchQueue.main)
                    .sink { completion in
                        switch completion{
                        case .finished:
                            print("성공")
                        case .failure(let err):
                            print("실패 : \(err)")
                        }
                    } receiveValue: {[weak self] image in
                        self?.threeImageView.image = image
                    }
                    .store(in: &self.subscription)

            }
            .store(in: &subscription)
        
        
        self.fourLoadButton.tapPublisher
            .sink {[weak self] _ in
                guard let self = self else{return}
                self.fourImageView.image = UIImage(systemName: "folder")
                self.imageDownload(url: self.imageUrls[3])
                    .receive(on: DispatchQueue.main)
                    .sink { completion in
                        switch completion{
                        case .finished:
                            print("성공")
                        case .failure(let err):
                            print("실패 : \(err)")
                        }
                    } receiveValue: {[weak self] image in
                        self?.fourImageView.image = image
                    }
                    .store(in: &self.subscription)
            }
            .store(in: &subscription)
        
        self.fiveLoadButton.tapPublisher
            .sink {[weak self] _ in
                guard let self = self else{return}
                self.fiveImageView.image = UIImage(systemName: "folder")
                self.imageDownload(url: self.imageUrls[4])
                    .receive(on: DispatchQueue.main)
                    .sink { completion in
                        switch completion{
                        case .finished:
                            print("성공")
                        case .failure(let err):
                            print("실패 : \(err)")
                        }
                    } receiveValue: {[weak self] image in
                        self?.fiveImageView.image = image
                    }
                    .store(in: &self.subscription)

            }
            .store(in: &subscription)
        
        
        self.allLoadButton.tapPublisher
            .sink {[weak self] _ in
                
                guard let self = self else {return}
                for i in 0..<self.imageUrls.count{
                    self.oneImageView.image = UIImage(systemName: "folder")
                    self.twoImageView.image = UIImage(systemName: "folder")
                    self.threeImageView.image = UIImage(systemName: "folder")
                    self.fourImageView.image = UIImage(systemName: "folder")
                    self.fiveImageView.image = UIImage(systemName: "folder")
                    
                    self.imageDownload(url: self.imageUrls[i])
                        .receive(on: DispatchQueue.main)
                        .sink { completion in
                            switch completion{
                            case .finished:
                                print("성공")
                            case .failure(let err):
                                print("실패 : \(err)")
                            }
                        } receiveValue: {[weak self] image in
                            if i == 0{
                                self?.oneImageView.image = image
                            }else if i == 1{
                                self?.twoImageView.image = image
                            }else if i == 2{
                                self?.threeImageView.image = image
                            }else if i == 3{
                                self?.fourImageView.image = image
                            }else if i == 4{
                                self?.fiveImageView.image = image
                            }
                            
                        }
                        .store(in: &self.subscription)
                }
            }
            .store(in: &subscription)
    }
    
    
    func convertURL(_ str: String) -> URL?{
        guard let url = URL(string: str) else {return nil}
        return url
    }
    //데이터가공을 좀더 열심히 해봐야겠다..
    func imageDownload(url: URL) -> AnyPublisher<UIImage, Error>{
        return URLSession.shared.dataTaskPublisher(for: url)
            .mapError({ err in
                err as Error
            })
            .map(\.data)
            .tryMap({ data -> UIImage in
                let image = UIImage(data: data)!
                return image
            })
            .eraseToAnyPublisher()
    }
    
}

//.sink(receiveCompletion: { completion in
//switch completion{
//case .finished:
//    print("\(url) load success")
//case .failure(let err):
//    print("\(url) \(err)")
//}
//}, receiveValue: {[weak self] (data, _) in
//let image = UIImage(data: data)
//
//if url == self?.imageUrls[0]{
//    self?.oneImageView.image = image
//}else if url == self?.imageUrls[1]{
//    self?.twoImageView.image = image
//}else if url == self?.imageUrls[2]{
//    self?.threeImageView.image = image
//}else if url == self?.imageUrls[3]{
//    self?.fourImageView.image = image
//}else if url == self?.imageUrls[4]{
//    self?.fiveImageView.image = image
//}
//})
