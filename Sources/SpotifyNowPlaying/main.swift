import Cocoa
import Foundation

class SpotifyNowPlayingApp: NSObject, NSApplicationDelegate {
    var statusItem: NSStatusItem?

    func applicationDidFinishLaunching(_ notification: Notification) {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)

        if let button = statusItem?.button {
            button.title = "🎵 Loading..."
        }

        updateTrackInfo()

        Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { _ in
            self.updateTrackInfo()
        }
    }

    @objc func updateTrackInfo() {
        let trackInfo = getSpotifyTrack()
        DispatchQueue.main.async {
            if let button = self.statusItem?.button {
                button.title = trackInfo
            }
        }
    }

    func getSpotifyTrack() -> String {
        let script = """
        tell application "Spotify"
            if player state is playing then
                return "🎵 " & artist of current track & " - " & name of current track
            else
                return "No song playing"
            end if
        end tell
        """

        var error: NSDictionary?
        if let appleScript = NSAppleScript(source: script) {
            var output: NSAppleEventDescriptor?
            output = appleScript.executeAndReturnError(&error)

            if let result = output?.stringValue {
                return result
            } else {
                return "⚠️ Error getting track"
            }
        }
        return "⚠️ Failed to execute script"
    }
}

// Start the macOS menu bar app
let app = NSApplication.shared
let delegate = SpotifyNowPlayingApp()
app.delegate = delegate
app.run()
