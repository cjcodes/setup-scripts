#!/usr/bin/env python3
import sys
from datetime import datetime

try:
    from Foundation import NSObject
    from AppKit import NSWorkspace, NSWorkspaceDidActivateApplicationNotification, NSWorkspaceApplicationKey
    from PyObjCTools import AppHelper
except ImportError:
    print("❌ Error: pyobjc is required.")
    print("Please make sure you are running inside your virtual environment (source venv/bin/activate).")
    exit(1)

# Define an observer class to catch the macOS system notifications
class FocusObserver(NSObject):
    def handleFocusChange_(self, notification):
        try:
            # Extract the application information from the notification payload
            app_info = notification.userInfo().objectForKey_(NSWorkspaceApplicationKey)
            if app_info:
                name = app_info.localizedName()
                bundle_id = app_info.bundleIdentifier()
                pid = app_info.processIdentifier()
                timestamp = datetime.now().strftime('%Y-%m-%d %H:%M:%S.%f')[:-3]
                
                print(f"[{timestamp}] 🔴 Focus Switched -> App: {name} | PID: {pid} | BundleID: {bundle_id}")
                sys.stdout.flush()  # Forces terminal to print instantly
        except Exception as e:
            print(f"Error reading focus event: {e}")

def main():
    print("🔍 Event-Driven Focus Monitor Started.")
    print("Waiting for focus changes... (Press Ctrl+C to stop)\n")
    
    # Get the shared workspace notification center
    workspace = NSWorkspace.sharedWorkspace()
    notification_center = workspace.notificationCenter()
    
    # Initialize our observer and register for application activation events
    observer = FocusObserver.alloc().init()
    notification_center.addObserver_selector_name_object_(
        observer,
        "handleFocusChange:",  # The trailing colon maps to the underscore in python
        NSWorkspaceDidActivateApplicationNotification,
        None
    )
    
    try:
        # Start the native macOS console event loop to process notifications
        AppHelper.runConsoleEventLoop(installInterrupt=True)
    except KeyboardInterrupt:
        print("\n👋 Focus Monitor Stopped.")

if __name__ == '__main__':
    main()
