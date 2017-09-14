//
//  KKDetailVC.swift
//  KKFriends
//
//  Created by M_Li on 2017/9/14.
//  Copyright © 2017年 M_Li. All rights reserved.
//

import UIKit

class KKDetailVC: UIViewController {

    
    
    @IBOutlet weak var songName: UILabel!
    @IBOutlet weak var singerName: UILabel!
    @IBOutlet weak var costTimeLabel: UILabel!
    @IBOutlet weak var totalTimeLabel: UILabel!
    
    @IBOutlet weak var volumeSlide: UISlider!
    @IBOutlet weak var progressSlide: UISlider!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Slide事件：
    
    @IBAction func tapAction(_ sender: UITapGestureRecognizer) {//需设置progressSlide为delegate
        
        
    }
    @IBAction func valueChanged(_ sender: UISlider) {
    }
    
    @IBAction func touchUp(_ sender: Any) {
    }
    
    @IBAction func touchDown(_ sender: UISlider) {
    }
    
    
    @IBAction func playOrpauseAction(_ sender: UIButton) {
    }
    
    @IBAction func nextButtonAction(_ sender: UIButton) {
    }
    @IBAction func preButtonAction(_ sender: UIButton) {
    }
    

}
