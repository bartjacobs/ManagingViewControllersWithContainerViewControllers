//
//  MasterViewController.swift
//  ViewControllerContainment
//
//  Created by Bart Jacobs on 01/05/16.
//  Copyright © 2016 Bart Jacobs. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController {

    @IBOutlet var childViewControllersView: UIView!
    @IBOutlet var segmentedControl: UISegmentedControl!

    lazy var summaryViewController: SummaryViewController = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())

        // Instantiate View Controller
        var viewController = storyboard.instantiateViewControllerWithIdentifier("SummaryViewController") as! SummaryViewController

        // Add View Controller as Child View Controller
        self.addViewControllerAsChildViewController(viewController)

        return viewController
    }()

    lazy var sessionsViewController: SessionsViewController = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())

        // Instantiate View Controller
        var viewController = storyboard.instantiateViewControllerWithIdentifier("SessionsViewController") as! SessionsViewController

        // Add View Controller as Child View Controller
        self.addViewControllerAsChildViewController(viewController)
        
        return viewController
    }()

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    // MARK: - View Methods

    func setupView() {
        setupSegmentedControl()

        updateView()
    }

    func updateView() {
        summaryViewController.view.hidden = !(segmentedControl.selectedSegmentIndex == 0)
        sessionsViewController.view.hidden = (segmentedControl.selectedSegmentIndex == 0)
    }

    func setupSegmentedControl() {
        // Configure Segmented Control
        segmentedControl.removeAllSegments()
        segmentedControl.insertSegmentWithTitle("Summary", atIndex: 0, animated: false)
        segmentedControl.insertSegmentWithTitle("Sessions", atIndex: 1, animated: false)
        segmentedControl.addTarget(self, action: #selector(selectionDidChange(_:)), forControlEvents: .ValueChanged)

        // Select First Segment
        segmentedControl.selectedSegmentIndex = 0
    }

    // MARK: - Actions

    func selectionDidChange(sender: UISegmentedControl) {
        updateView()
    }

    // MARK: - Helper Methods

    private func addViewControllerAsChildViewController(viewController: UIViewController) {
        // Add Child View Controller
        addChildViewController(viewController)

        // Add Child View as Subview
        childViewControllersView.addSubview(viewController.view)

        // Configure Child View
        viewController.view.frame = childViewControllersView.bounds
        viewController.view.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]

        // Notify Child View Controller
        viewController.didMoveToParentViewController(self)
    }
    
    private func removeViewControllerAsChildViewController(viewController: UIViewController) {
        // Notify Child View Controller
        viewController.willMoveToParentViewController(nil)

        // Remove Child View From Superview
        viewController.view.removeFromSuperview()

        // Notify Child View Controller
        viewController.removeFromParentViewController()
    }
    
}
