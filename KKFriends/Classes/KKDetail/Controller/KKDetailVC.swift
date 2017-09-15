//
//  KKDetailVC.swift
//  KKFriends
//
//  Created by M_Li on 2017/9/14.
//  Copyright © 2017年 M_Li. All rights reserved.
//

import UIKit

class KKDetailVC: UIViewController,UIScrollViewDelegate {

    @IBOutlet weak var songName: UILabel!
    @IBOutlet weak var singerName: UILabel!
    @IBOutlet weak var costTimeLabel: UILabel!
    @IBOutlet weak var totalTimeLabel: UILabel!
    @IBOutlet weak var volumeSlide: UISlider!
    @IBOutlet weak var progressSlide: UISlider!
    lazy var lrcVC:KKLrcController = {
        return KKLrcController()
    }()
    @IBOutlet weak var lrcLabel: KKLrcLabelExtenion!
    @IBOutlet weak var lrcScrollView: UIScrollView!
    var timer:Timer?
    var linker:CADisplayLink?
    
    @IBOutlet weak var playOrpause: UIButton!
    @IBOutlet weak var foreImageV: UIImageView!
    @IBOutlet weak var vlumeSlide: UISlider!
    
    
    /*________________________*/
    
    @IBAction func backAction(_ sender: UIButton) {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    //Slide事件
    @IBAction func tapAction(_ sender: UITapGestureRecognizer) {
        //需设置progressSlide为delegate
        let value = sender.location(in: sender.view).x / (sender.view?.width)!
        progressSlide.value = Float(value)
        let totalTime = KKMusicOperationTool.sharedInstance.getMusicMessage().totalTime
        let costTime = totalTime * TimeInterval(value)
        KKMusicOperationTool.sharedInstance.seekToTimeInterval(costTime)
    }
    @IBAction func valueChanged(_ sender: UISlider) {
        let messageM = KKMusicOperationTool.sharedInstance.getMusicMessage()
        let costTime = messageM.totalTime * TimeInterval(progressSlide.value)
        //更新已经播放时长
        costTimeLabel.text = KKTimeTool.getFormateTime(costTime)
    }
    @IBAction func touchUp(_ sender: Any) {
       let messageM = KKMusicOperationTool.sharedInstance.getMusicMessage()
        let costTime = messageM.totalTime * TimeInterval(progressSlide.value)
        addTimer()
        //更新已经播放的时长
        KKMusicOperationTool.sharedInstance.seekToTimeInterval(costTime)
    }
    @IBAction func touchDown(_ sender: UISlider) {
        removeTimer()
    }
    @IBAction func playOrpauseAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            KKMusicOperationTool.sharedInstance.playCurrentMusic()
            foreImageV.layer.resumeAnimation()
        }else{
            KKMusicOperationTool.sharedInstance.pauseCurrentMusic()
            foreImageV.layer.pauseAnimation()
        }
    }
    @IBAction func nextButtonAction(_ sender: UIButton) {
        KKMusicOperationTool.sharedInstance.nextMusic()
    }
    @IBAction func preButtonAction(_ sender: UIButton) {
        KKMusicOperationTool.sharedInstance.preMusic()
    }
    
    /*________________viewDidLoad______________*/
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateOnce()
        addTimer()
        addLinker()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeTimer()
        removeLinker()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        lrcVC.tableView.backgroundColor = UIColor.clear
        lrcScrollView.delegate = self
        lrcScrollView.addSubview(lrcVC.tableView)
        lrcScrollView.isPagingEnabled = true
        lrcScrollView.showsVerticalScrollIndicator = true
        lrcScrollView.showsHorizontalScrollIndicator = false
        
        NotificationCenter.default.addObserver(self, selector: #selector(nextButtonAction(_:)), name: Notification.Name(rawValue:kPlayerDidFinishedNotification), object: nil)
    }
    func addTimer(){
        timer = Timer(timeInterval: 1, target: self, selector: #selector(updateTimers), userInfo: nil, repeats: true)
        RunLoop.current.add(timer!, forMode: .commonModes)
    }
    func addLinker(){
        linker = CADisplayLink(target: self, selector: #selector(updateLrc))
        linker?.add(to: RunLoop.current, forMode: RunLoopMode.commonModes)
        
    }
    func removeTimer(){
        timer?.invalidate()
        timer = nil
    }
    func removeLinker(){
        linker?.invalidate()
        linker = nil
    }
    func updateTimers(){//更新播放进度
        let messageM = KKMusicOperationTool.sharedInstance.getMusicMessage()
        progressSlide.value = Float((messageM.costTime) / messageM.totalTime)
        costTimeLabel.text = messageM.costTimeFormat // KKTimeTool.getFormateTime(messageM.costTime)
        playOrpause.isSelected = messageM.isPlaying
    }
    func updateLrc(){//更新歌词进度
        let musicMessageM = KKMusicOperationTool.sharedInstance.getMusicMessage()
        let costTime = musicMessageM.costTime
        let rowLrcM = KKMusicDataManager.getCurrentLrcM(costTime, lrcMs:lrcVC.lrcMs)
        let lrcM = rowLrcM.lrcM
        lrcLabel.text = lrcM?.lrcContent
        if lrcM != nil {
            lrcLabel.progress = CGFloat((costTime - lrcM!.beginTime) / (lrcM!.endTime - lrcM!.beginTime))
            lrcVC.progress = lrcLabel.progress
        }
        lrcVC.scrollRow = rowLrcM.row
    
        //设置锁屏信息
        if UIApplication.shared.applicationState == .background {
            KKMusicOperationTool.sharedInstance.setupLockMessage()
        }
    }
    
    func updateOnce(){
    
        let messageM = KKMusicOperationTool.sharedInstance.getMusicMessage()
        guard let musicM = messageM.music else { return }
        if musicM.icon != nil {
            foreImageV.image = UIImage(named: musicM.icon!)!
        }
        songName.text = musicM.songname
        singerName.text = musicM.singername
        
        totalTimeLabel.text = messageM.totalTimeForamt // KKTimeTool.getFormateTime(messageM.totalTime)
        volumeSlide.value = KKMusicOperationTool.sharedInstance.musicTool.volume
        
        //歌词显示
        lrcVC.lrcMs = KKMusicDataManager.getLrcModelS(musicM.lrcname)
        //大图旋转图
        foreImageV.layer.removeAnimation(forKey: "roration")
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.fromValue = 0
        animation.toValue = Double.pi * 2
        animation.duration = 30
        
        animation.isRemovedOnCompletion = false
        animation.repeatCount = MAXFLOAT
        foreImageV.layer.add(animation, forKey: "rotation")
        
        if messageM.isPlaying {
            foreImageV.layer.resumeAnimation()
        }else{
            foreImageV.layer.pauseAnimation()
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        lrcVC.tableView.frame = lrcScrollView.bounds
        lrcVC.tableView.x = lrcScrollView.width
        
        lrcScrollView.contentSize = CGSize(width: lrcScrollView.width * 2, height: 0)
        lrcScrollView.layer.cornerRadius = lrcScrollView.width * 0.5
        lrcScrollView.layer.masksToBounds = true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let progress = 1 - scrollView.contentOffset.x / scrollView.width
        foreImageV.alpha = progress
        lrcLabel.alpha = progress
    }
    
    override func remoteControlReceived(with event: UIEvent?) {
        switch (event?.subtype)! {
            
        case .remoteControlPlay:
            KKMusicOperationTool.sharedInstance.playCurrentMusic()
        case .remoteControlPause:
            KKMusicOperationTool.sharedInstance.pauseCurrentMusic()
        case .remoteControlNextTrack:
            KKMusicOperationTool.sharedInstance.nextMusic()
        case .remoteControlPreviousTrack:
            KKMusicOperationTool.sharedInstance.preMusic()
        default:
            print("remote Coutrol")
        }
        updateOnce()
    }
    
    
    

}
