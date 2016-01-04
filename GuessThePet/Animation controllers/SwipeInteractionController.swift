//
//  SwipeInteractionController.swift
//  GuessThePet
//
//  Created by Warif Akhand Rishi on 1/4/16.
//  Copyright © 2016 Razeware LLC. All rights reserved.
//

import UIKit

class SwipeInteractionController: UIPercentDrivenInteractiveTransition {

    var interactionInProgress = false
    private var shouldCompleteTransition = false
    private weak var viewController: UIViewController!
    
    func wireToViewController(viewController: UIViewController!) {
        self.viewController = viewController
        prepareGestureRecognizerInView(viewController.view)
    }
    
    private func prepareGestureRecognizerInView(view: UIView) {
        let gesture = UIScreenEdgePanGestureRecognizer(target: self, action: "handleGesture:")
        gesture.edges = UIRectEdge.Left
        view.addGestureRecognizer(gesture)
    }
    
    func handleGesture(gestureRecognizer: UIScreenEdgePanGestureRecognizer) {
        
        // 1
        let translation = gestureRecognizer.translationInView(gestureRecognizer.view!.superview!)
        var progress = (translation.x / 200)
        progress = CGFloat(fminf(fmaxf(Float(progress), 0.0), 1.0))
        
        switch gestureRecognizer.state {
            
        case .Began:
            // 2
            interactionInProgress = true
            viewController.dismissViewControllerAnimated(true, completion: nil)
            
        case .Changed:
            // 3
            shouldCompleteTransition = progress > 0.5
            updateInteractiveTransition(progress)
            
        case .Cancelled:
            // 4
            interactionInProgress = false
            cancelInteractiveTransition()
            
        case .Ended:
            // 5
            interactionInProgress = false
            
            if !shouldCompleteTransition {
                cancelInteractiveTransition()
            } else {
                finishInteractiveTransition()
            }
            
        default:
            print("Unsupported")
        }
    }
}
