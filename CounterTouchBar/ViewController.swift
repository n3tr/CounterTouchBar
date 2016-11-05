//
//  ViewController.swift
//  CounterTouchBar
//
//  Created by Jirat Ki. on 10/29/2559 BE.
//  Copyright © 2559 Jirat Ki. All rights reserved.
//

import Cocoa

fileprivate extension NSTouchBarCustomizationIdentifier {
    static let counterTouchBar = NSTouchBarCustomizationIdentifier("com.n3tr.countertouchbar.counter")
}

fileprivate extension NSTouchBarItemIdentifier {
    static let increase = NSTouchBarItemIdentifier("com.n3tr.countertouchbar.increase")
    static let decrease = NSTouchBarItemIdentifier("com.n3tr.countertouchbar.decrease")
    static let counter = NSTouchBarItemIdentifier("com.n3tr.countertouchbar.counter")
}

class ViewController: NSViewController {
    
    
    dynamic var currentCounter = 0
    
    @IBOutlet weak var counterLabel: NSTextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        counterLabel.bind("stringValue", to: self, withKeyPath: #keyPath(currentCounter), options: nil)
    }
    
    deinit {
        counterLabel.unbind("stringValue")
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    override func makeTouchBar() -> NSTouchBar? {
        let touchBar = NSTouchBar()
        touchBar.delegate = self
        touchBar.customizationIdentifier = .counterTouchBar
        touchBar.defaultItemIdentifiers = [.increase, .counter, .decrease, .otherItemsProxy]
        return touchBar
    }
    
    func increaseCounter() {
        currentCounter += 1
    }
    
    func decreaseCounter() {
        currentCounter -= 1
    }
    
}

extension ViewController: NSTouchBarDelegate {
    func touchBar(_ touchBar: NSTouchBar, makeItemForIdentifier identifier: NSTouchBarItemIdentifier) -> NSTouchBarItem? {
        switch identifier {
            
        // Increase Item
        case NSTouchBarItemIdentifier.increase:
            let button = NSButton(title: "+", target: self, action: #selector(ViewController.increaseCounter))
            let increaseItem = NSCustomTouchBarItem(identifier: identifier)
            increaseItem.customizationLabel = "Counter +"
            increaseItem.view = button
            return increaseItem
            
        // Decrease Item
        case NSTouchBarItemIdentifier.decrease:
            let button = NSButton(title: "-", target: self, action: #selector(ViewController.decreaseCounter))
            
            let decreaseItem = NSCustomTouchBarItem(identifier: identifier)
            decreaseItem.customizationLabel = "Counter -"
            decreaseItem.view = button
            return decreaseItem
        
        // Counter Label
        case NSTouchBarItemIdentifier.counter:
            let label = NSTextField(string: "0")
            label.textColor = NSColor.green
            label.alignment = .center
            label.bind("stringValue", to: self, withKeyPath: #keyPath(currentCounter), options: nil)
            
            let counter = NSCustomTouchBarItem(identifier: identifier)
            counter.customizationLabel = "Counter"
            counter.view = label
            
            let labelLayout = NSLayoutConstraint.constraints(withVisualFormat: "H:[label(60)]",
                                                             options: [],
                                                             metrics: nil,
                                                             views: ["label": label])
            NSLayoutConstraint.activate(labelLayout)
            
            return counter
        default:
            return nil
        }
    }
}

