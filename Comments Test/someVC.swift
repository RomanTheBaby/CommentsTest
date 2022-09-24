//
//  someVC.swift
//  Comments Test
//
//  Created by Roman on 2022-09-23.
//

import UIKit


/// This is just a mock
private class SomeCell: UICollectionViewCell, Reusable, NibLoadable {

}

class SomeVC: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    
    // MARK: - Private Properties
    
    @IBOutlet private var detailViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet private var collectionView: UICollectionView!
    @IBOutlet private var detailView: UIView!
    
    // name strill depends on what it actually is. String is just an example
    private var dataArray: [String] = []
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(SomeCell.nib, forCellWithReuseIdentifier: SomeCell.reuseIdentifier)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action:#selector(dissmissController(_:)))
        
        fetchData()
    }
    
    
    // MARK: - Private Methods
    
    private func fetchData() {
        let url = URL(string: "testreq")!
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let data = data,
                  let strings = String(data: data, encoding: .utf8)?.components(separatedBy: ",") else {
                return
            }
            
            // dataArray depends on what data actually is
            self?.dataArray = strings
            self?.collectionView.reloadData()
        }
        task.resume()
    }
    
    
    // MARK: - Actions Handling
    
    @objc private func dissmissController(_ sender: UIBarButtonItem) {
//        ???
//        dismiss(animated: true)
    }
    
    @IBAction private func cloShowDetails() {
        detailViewWidthConstraint.constant = 0
        
        UIView.animate(withDuration: 0.5, animations: {
            /// Or more fancy animation
            self.detailView.isHidden = true
        })
    }
    
    @IBAction private func showDetail() {
        detailViewWidthConstraint.constant = 100
        
        UIView.animate(withDuration: 0.5, animations: {
            /// Or more fancy animation
            self.detailView.isHidden = false
        })

    }
    
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    
    // MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showDetail()
    }
    
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthMultiplier: CGFloat = UIDevice.current.isIPhone ? 0.9 : 0.2929
        return CGSize(width: view.frame.width * widthMultiplier, height: 150.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
                        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if UIDevice.current.isIPhone {
            return 24
        }
        
        let frameWidth = (view.frame.width * 0.2929 * 3) + 84
        return (view.frame.width - frameWidth) / 2
    }
    
}


private extension UIDevice {
    var isIPhone: Bool {
        userInterfaceIdiom == .phone
    }
}
