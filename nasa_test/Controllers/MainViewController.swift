//
//  MainViewController.swift
//  nasa_test
//
//  Created by Dumitru Rahmaniuc on 22.07.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    //MARK: UI Elements
    private lazy var roverTypeCV: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.itemSize = CGSize(width: 370, height: 100)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.register(RoverTypeCell.self, forCellWithReuseIdentifier: RoverTypeCell.identifier)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    //MARK: Variables
    var roverType = [
    "Curiosity",
    "Opportunity",
    "Spirit"
    ]
    //MARK: Functions
    func setupUI(){
        view.addSubviews(roverTypeCV)
        
        roverTypeCV.snp.makeConstraints{
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        roverTypeCV.delegate = self
        roverTypeCV.dataSource = self
        setupUI()
    }
}
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return roverType.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RoverTypeCell.identifier, for: indexPath) as? RoverTypeCell else {return UICollectionViewCell()}
        cell.setup(title: roverType[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row{
        case 0:
            self.navigationController?.pushViewController(RoverViewController(rootOption: .curiosity), animated: true)
        case 1:
            self.navigationController?.pushViewController(RoverViewController(rootOption: .opportunity), animated: true)
        case 2:
            self.navigationController?.pushViewController(RoverViewController(rootOption: .spirit), animated: true)
        default:
            break
        }
    }
}
