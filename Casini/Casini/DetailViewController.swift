//
//  DetailViewController.swift
//  Casini
//
//  Created by Dang Duy Cuong on 9/14/20.
//  Copyright © 2020 Dang Duy Cuong. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.minimumZoomScale = 0.25
            scrollView.maximumZoomScale = 3.5
        }
    }
    
    var urlImage: String?


    func configureView() {
        // Update the user interface for the detail item.
        if let urlImage = urlImage, let imageView = imageView {
            indicatorView.startAnimating()
            DispatchQueue.global().async {
                guard let url = URL(string: urlImage) else {
                    return
                }
                guard let data = try? Data(contentsOf: url) else {
                    return
                }
                DispatchQueue.main.async {
                    imageView.alpha = 0.35
                    UIView.animate(withDuration: 0.35, animations: {
                        self.indicatorView.stopAnimating()
                        imageView.alpha = 1
                        imageView.image = UIImage(data: data)
                    })
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureView()
    }

    var detailItem: NSDate? {
        didSet {
            // Update the view.
            configureView()
        }
    }


}

extension DetailViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
