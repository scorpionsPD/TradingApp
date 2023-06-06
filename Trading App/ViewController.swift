//
//  ViewController.swift
//  Trading App
//
//  Created by Pradeep Dahiya on 05/06/2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let client = FinnhubWebSocketClient()
        client.connect()
        RunLoop.main.run()
    }
}

