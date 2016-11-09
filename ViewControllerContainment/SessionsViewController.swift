//
//  SessionsViewController.swift
//  ViewControllerContainment
//
//  Created by Bart Jacobs on 01/05/16.
//  Copyright © 2016 Bart Jacobs. All rights reserved.
//

import UIKit

final class SessionsViewController: UIViewController {

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        print("Sessions View Controller Will Appear")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        print("Sessions View Controller Will Disappear")
    }
    
}
