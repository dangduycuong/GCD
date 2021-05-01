//
//  GroupGCDViewController.swift
//  Casini
//
//  Created by Boss on 01/05/2021.
//  Copyright © 2021 Dang Duy Cuong. All rights reserved.
// Khi có nhiều task thực hiện đồng thời. Và chúng đều update UI.
//https://fxstudio.dev/grand-central-dispatch-managing-task/

//Giải quyết
//Để giải quyết yêu cầu bài toán thì GCD đưa ra DispatchGroup
//Nhóm các task cần thực hiện lại, nhất là các task bất đồng bộ
//Quản lý được việc thực thi của các task
//Quyết định được việc chờ đợi để hoàn thành hay không.

import UIKit

class GroupGCDViewController: UIViewController {
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.global(qos: .userInitiated).async {
            //1
            let dispatchGroup = DispatchGroup()
            //2
            dispatchGroup.enter()
            self.showLoading()
            //3
            self.taskOne {
                print("ONE -> DONE")
                //4
                dispatchGroup.leave()
            }
            
            dispatchGroup.enter()
            self.taskTwo {
                print("TWO -> DONE")
                dispatchGroup.leave()
            }
            
            dispatchGroup.enter()
            self.taskThree {
                print("THREE -> DONE")
                dispatchGroup.leave()
            }
            
            //5
            dispatchGroup.notify(queue: .main) {
                print("ALL DONE")
                self.spinner.stopAnimating()
            }
        }
    }
    
//    Thêm call back, để thông báo việc kết thúc function khi thực hiện bất đồng bộ
//    Sử dụng thêm các closure để thông báo việc hoàn thành các task
    
    func taskOne(completion: @escaping () -> Void) {
        print("task one")
        let link = "https://images-assets.nasa.gov/image/DSC_1477/DSC_1477~orig.jpg"
        
        
        if let url = URL(string: link) {
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                        completion()
                        self.imageView1.image = image
                    })
                }
            }
        }
        //        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
        //            completion()
        //        }
    }
    
    func taskTwo(completion: @escaping () -> Void) {
        print("task two")
        
        //        let link = "images-assets.nasa.gov/image/PIA24595/PIA24595~orig.jpg"
        
        let link = "https://www.thecocktaildb.com/images/media/drink/vrwquq1478252802.jpg"
        
        if let url = URL(string: link) {
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        completion()
                        self.imageView2.image = image
                    }
                }
            }
        }
        
        //        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
        //            completion()
        //        }
    }
    
    func taskThree(completion: @escaping () -> Void) {
        print("task three")
        let link = "https://images-assets.nasa.gov/image/DSC_1624b/DSC_1624b~orig.jpg"
        
        if let url = URL(string: link) {
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        completion()
                        self.imageView3.image = image
                    }
                }
            }
        }
        //        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
        //            completion()
        //        }
    }
    
    func showLoading() {
        DispatchQueue.main.async {
            self.spinner.startAnimating()
        }
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
            self.spinner.stopAnimating()
        }
    }
    
}
