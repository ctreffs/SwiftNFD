//
//  AppDelegate.swift
//  NFD-Demo
//
//  Created by Christian Treffs on 05.11.21.
//

import Cocoa
import NFD

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    @IBOutlet var window: NSWindow!

    @IBAction func openDialog(_: NSButton) { print(NFD.OpenDialog(filter: getFileExtFilters)) }
    @IBAction func openDialogMultiple(_: NSButton) { print(NFD.OpenDialogMultiple(filter: getFileExtFilters)) }
    @IBAction func openSaveDialog(_: NSButton) { print(NFD.SaveDialog(filter: getFileExtFilters)) }
    @IBAction func openPickFolder(_: NSButton) { print(NFD.PickFolder()) }
    @IBOutlet var fileExtFilters: NSTextFieldCell!

    var getFileExtFilters: [String]? {
        let string = fileExtFilters.stringValue
        if string.isEmpty {
            return nil
        }
        return string.components(separatedBy: ";")
    }

    func applicationShouldTerminateAfterLastWindowClosed(_: NSApplication) -> Bool {
        true
    }
}
