//
//  MasterViewController.swift
//  ViewControllerContainment
//
//  Created by Bart Jacobs on 01/05/16.
//  Copyright © 2016 Bart Jacobs. All rights reserved.
//

import UIKit

enum Selection: Int {
    case summary
    case sessions
}

final class MasterViewController: UIViewController {

    // MARK: - Properties

    @IBOutlet var segmentedControl: UISegmentedControl!

    // MARK: -

    private var viewControllers = [Selection: UIViewController]()

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    // MARK: - View Methods

    private func setupView() {
        setupSegmentedControl()

        updateView()
    }

    private func updateView() {
        if segmentedControl.selectedSegmentIndex == Selection.summary.rawValue {
            // Remove Sessions View Controller
            remove(asChildViewController: viewControllers[.sessions])

            // Create Summary View Controller
            viewControllers[.summary] = viewControllers[.summary] ?? createSummaryViewController()

            // Add Summary View Controller
            add(asChildViewController: viewControllers[.summary])

        } else {
            // Remove Summary View Controller
            remove(asChildViewController: viewControllers[.summary])

            // Create Sessions View Controller
            viewControllers[.sessions] = viewControllers[.sessions] ?? createSessionsViewController()

            // Add Sessions View Controller
            add(asChildViewController: viewControllers[.sessions])
        }
    }

    private func setupSegmentedControl() {
        // Configure Segmented Control
        segmentedControl.removeAllSegments()
        segmentedControl.insertSegment(withTitle: "Summary", at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: "Sessions", at: 1, animated: false)
        segmentedControl.addTarget(self, action: #selector(selectionDidChange(_:)), for: .valueChanged)

        // Select First Segment
        segmentedControl.selectedSegmentIndex = 0
    }

    // MARK: - Actions

    func selectionDidChange(_ sender: UISegmentedControl) {
        updateView()
    }

    // MARK: - Helper Methods

    private func add(asChildViewController viewController: UIViewController?) {
        guard let viewController = viewController else { return }

        // Add Child View Controller
        addChildViewController(viewController)

        // Add Child View as Subview
        view.addSubview(viewController.view)

        // Configure Child View
        viewController.view.frame = view.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        // Notify Child View Controller
        viewController.didMove(toParentViewController: self)
    }
    
    private func remove(asChildViewController viewController: UIViewController?) {
        guard let viewController = viewController else { return }

        // Notify Child View Controller
        viewController.willMove(toParentViewController: nil)

        // Remove Child View From Superview
        viewController.view.removeFromSuperview()

        // Notify Child View Controller
        viewController.removeFromParentViewController()
    }

    // MARK: -

    private func createSummaryViewController() -> SummaryViewController {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)

        // Instantiate View Controller
        let viewController = storyboard.instantiateViewController(withIdentifier: "SummaryViewController") as! SummaryViewController

        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)

        return viewController
    }

    private func createSessionsViewController() -> SessionsViewController {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)

        // Instantiate View Controller
        let viewController = storyboard.instantiateViewController(withIdentifier: "SessionsViewController") as! SessionsViewController

        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)

        return viewController
    }

}
