//
//  WindowController.swift
//  CounterTouchBar
//
//  Created by Jirat Ki. on 10/29/2559 BE.
//  Copyright © 2559 Jirat Ki. All rights reserved.
//

import Cocoa

fileprivate extension NSTouchBarCustomizationIdentifier {
    static let touchBar = NSTouchBarCustomizationIdentifier("com.n3tr.countertouchbar.touchbar")
}

fileprivate extension NSTouchBarItemIdentifier {
    static let label = NSTouchBarItemIdentifier("com.n3tr.countertouchbar.label")
}

class WindowController: NSWindowController {
    
    override func windowDidLoad() {
        super.windowDidLoad()
    }
    
    override func makeTouchBar() -> NSTouchBar? {
        let touchBar = NSTouchBar()
        touchBar.delegate = self
        touchBar.customizationIdentifier = .touchBar
        touchBar.defaultItemIdentifiers = [.label]
        return touchBar
    }

}

extension WindowController: NSTouchBarDelegate {
    
    func touchBar(_ touchBar: NSTouchBar, makeItemForIdentifier identifier: NSTouchBarItemIdentifier) -> NSTouchBarItem? {
        switch identifier {
        case NSTouchBarItemIdentifier.label:
            // Create custom touch bar Item
            let custom = NSCustomTouchBarItem(identifier: identifier)
            custom.customizationLabel = "Label Title"
            
            // Create label as NSTextField
            let label = NSTextField(labelWithString: "Hello, TouchBar")
            label.textColor = NSColor.green
            
            // Assign custom item's view
            custom.view = label
            
            return custom
        default:
            return nil
        }
    }
}
