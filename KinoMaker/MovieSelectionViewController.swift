import SnapKit
import UIKit


final class MovieSelectionViewController: UIViewController {

    private let viewModel: MovieSelectionViewModel
    private let repository = Repository()
    private var films = [FilmInfo]()
    private var index = 0
    
    // MARK: - UI
    
    let coverView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let posterImage: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .yellow
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = .zero
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let positiveButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(didTapPositiveButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Initialize
    
    init(viewModel: MovieSelectionViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Livecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        getRandomFilm()
        setupLayout()
        setupGesture()
    }
    
}

// MARK: - Private functions

private extension MovieSelectionViewController {
    
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
        
        if UserDefaultsManager.filmArray.isEmpty {
            print("from Network")
            repository.getRandomFilm { result in
                RequestTracker.shared.trackRequest()
                
                switch result {
                case .success(let model):
                    UserDefaultsManager.filmArray = model.docs
                    print(model.docs.count)
                    print(model.limit)
                    //                let array = model.docs[0].poster.previewURL
                    let path = model.docs[0].logo?.url
                    self.posterImage.loadImageFromUrl(path: path)
                    self.descriptionLabel.text = model.docs[0].description
                    
                case .failure(let failure):
                    print("error getRandomFilm: \(failure.localizedDescription)")
                }
            }
        } else {
            print("from DB")
            films = UserDefaultsManager.filmArray
            self.updateView(with: index)
        }
    }
    
    func updateView(with index: Int) {
        let path = films[index].poster.previewURL
        posterImage.loadImageFromUrl(path: path)
        descriptionLabel.text = films[index].description
    }
    
    func setupLayout() {
        view.addSubview(coverView)
        NSLayoutConstraint.activate([
            coverView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            coverView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            coverView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            coverView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        
        [posterImage, descriptionLabel, positiveButton].forEach { coverView.addSubview($0) }
        
        posterImage.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.5)
            $0.width.equalToSuperview().multipliedBy(0.6)
        }
        
        positiveButton.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(posterImage.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    func setupGesture() {
        let tap = UIPanGestureRecognizer(target: self, action: #selector(didAction))
        coverView.addGestureRecognizer(tap)
        coverView.isUserInteractionEnabled = true
    }
    
    @objc func didAction(_ sender: UIPanGestureRecognizer) {
        guard let card = sender.view else {
            return
        }
        
        let point = sender.translation(in: card)
        let xFromCenter = card.center.x - self.view.center.x

        card.center = CGPoint(x: card.center.x + point.x, y: card.center.y + point.y)
        
        if xFromCenter > .zero {
            print("right")
        } else {
            print("left")
        }
        
        card.alpha = 1 - (abs(xFromCenter) / abs(self.view.center.x))
        
        if sender.state == UIGestureRecognizer.State.ended {
            UIView.animate(withDuration: 0.3) {
                card.center = self.view.center
                card.alpha = 1
            }
        }
        
        sender.setTranslation(.zero, in: card)
    }
    
    @objc func didTapPositiveButton() {
        index = Int(arc4random_uniform(251))
        updateView(with: index)
    }
    
}
