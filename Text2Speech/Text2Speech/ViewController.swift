//
//  ViewController.swift
//  Text2Speech
//
//  Created by zhouyi on 2017/4/17.
//  Copyright © 2017年 NewBornTown, Inc. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UITableViewController {
    private var audioPlayer : AVAudioPlayer?
    fileprivate var controllers: [[String : String]] = [
        [
            "name": "控制",
            "identifier": "MonitorViewController",
            ],
        [
            "name": "国际化",
            "identifier": "InternationalViewController",
            ],
        [
            "name":"混合",
            "identifier": "MixAudioAndSpeechViewController"
        ],
        [
            "name":"顺序控制",
            "identifier":"SpeechFlowViewController"
        ],
        [
            "name":"根据actionId 和 time 生成一个可以的FlowItem",
            "identifier":"UinitBySecondViewController"
        ],
        [
            "name":"背景音乐和滴滴声音混合",
            "identifier":"DoubleAudioViewController"
        ]
    
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return controllers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = controllers[indexPath.row]["name"]
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = controllers[indexPath.row]["identifier"]
        let vc = storyboard?.instantiateViewController(withIdentifier: id!)
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}

