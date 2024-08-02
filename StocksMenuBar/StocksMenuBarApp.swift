//
//  StocksMenuBarApp.swift
//  StocksMenuBar
//
//  Created by Marcelo Sampaio on 01/08/24.
//

import SwiftUI

@main
struct StocksMenuBarApp: App {
    
    @NSApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    
    var body: some Scene {
        WindowGroup {
            MenuBarView(vm: StockListViewModel.init())
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate, ObservableObject {
    private var statusItem: NSStatusItem!
    private var popover: NSPopover!
    
    private var stockListVM: StockListViewModel!
    
    @MainActor
    func applicationDidFinishLaunching(_ notification: Notification) {
        self.stockListVM = StockListViewModel()
        
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        if let statusButton = statusItem.button {
            statusButton.image = NSImage(systemSymbolName: "flag.2.crossed.fill", accessibilityDescription: "The Line")
            
            statusButton.action = #selector(togglePopover)
        }
        
        self.popover = NSPopover()
        self.popover.contentSize = NSSize(width: 300, height: 300)
        self.popover.behavior = .transient
        self.popover.contentViewController = NSHostingController(rootView: MenuBarView(vm: stockListVM))
    }
    
    @objc func togglePopover() {
        Task {
            await self.stockListVM.populateStocks()
        }
        
        if let button = statusItem.button {
            if popover.isShown {
                self.popover.performClose(nil)
            } else {
                
            }
        }
    }
}
