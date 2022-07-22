//
//  RoverScreen.swift
//  nasa_test
//
//  Created by Dumitru Rahmaniuc on 22.07.2022.
//

import Foundation
import UIKit



final class RoverViewController: UIViewController{
    
    // MARK: - UIElements
    private lazy var testCV: UICollectionView = {
        
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.itemSize = CGSize(width: 150, height: 150)
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .clear
        collectionView.register(RoverCell.self, forCellWithReuseIdentifier: RoverCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    // MARK: - Variables
    private var curiosity: [Photo] = []
    private var isFetchingData = false
    private var currentPage = 1
    var screenType: ScreenType!
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        fetchCuriosity()
    }
    
    // MARK: - Functions
    convenience init(rootOption option: ScreenType){
        self.init()
        screenType = option
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        view.addSubviews(testCV)
        testCV.snp.makeConstraints{
            $0.leading.trailing.bottom.top.equalToSuperview()
        }
    }
    
    private func fetchCuriosity() {
        
        APICaller.shared.getData(atPage: currentPage, atType: screenType.roverType) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
                
            case .success(let model):
                
                self.curiosity.append(contentsOf: model)
                self.isFetchingData = false
                self.currentPage += 1
                
                DispatchQueue.main.async {
                    self.testCV.reloadData()
                }
                
            case .failure(let error):
                self.showAlert(title: "Error", message: error.localizedDescription)
            }
        }
    }
}

// MARK: - Extension CollectionView DataSource

extension RoverViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return curiosity.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RoverCell.identifier, for: indexPath) as? RoverCell else {
            return UICollectionViewCell()
        }
        
        let curiosity = curiosity[indexPath.row]
        cell.setup(model: curiosity)

        return cell
    }
}

// MARK: - Extension CollectionView Delegate

extension RoverViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let lastCuriosity = curiosity.count - 1
        
        if indexPath.row == lastCuriosity && !isFetchingData {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.isFetchingData = true
                self.fetchCuriosity()
            }
        }
    }
}
