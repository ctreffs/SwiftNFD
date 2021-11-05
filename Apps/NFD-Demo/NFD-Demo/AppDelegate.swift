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

    @IBAction func openDialog(_: NSButton) { print(NFD.OpenDialog()) }
    @IBAction func openDialogMultiple(_: NSButton) { print(NFD.OpenDialogMultiple()) }
    @IBAction func openSaveDialog(_: NSButton) { print(NFD.SaveDialog()) }
    @IBAction func openPickFolder(_: NSButton) { print(NFD.PickFolder()) }

    func applicationDidFinishLaunching(_: Notification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_: NSApplication) -> Bool {
        true
    }
}
