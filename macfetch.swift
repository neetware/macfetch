import Foundation

let apple01:String=("\u{001B}[0;92m                     'c.           \u{001B}[0m")
let apple02:String=("\u{001B}[0;92m                  ,xNMM.           \u{001B}[0m")
let apple03:String=("\u{001B}[0;92m                .OMMMMo            \u{001B}[0m")
let apple04:String=("\u{001B}[0;92m                OMMM0,             \u{001B}[0m")
let apple05:String=("\u{001B}[0;92m      .;loddo:' loolloddol;.       \u{001B}[0m")
let apple06:String=("\u{001B}[0;92m    cKMMMMMMMMMMNWMMMMMMMMMMMM0:   \u{001B}[0m")
let apple07:String=("\u{001B}[0;92m  .KMMMMMMMMMMMMMMMMMMMMMMMMMWd.   \u{001B}[0m")
let apple08:String=("\u{001B}[0;92m  XMMMMMMMMMMMMMMMMMMMMMMMX.       \u{001B}[0m")
let apple09:String=("\u{001B}[0;92m ;MMMMMMMMMMMMMMMMMMMMMMMM:        \u{001B}[0m")
let apple10:String=("\u{001B}[0;92m :MMMMMMMMMMMMMMMMMMMMMMMM:        \u{001B}[0m")
let apple11:String=("\u{001B}[0;92m .MMMMMMMMMMMMMMMMMMMMMMMMX.       \u{001B}[0m")
let apple12:String=("\u{001B}[0;92m kMMMMMMMMMMMMMMMMMMMMMMMMWd.      \u{001B}[0m")
let apple13:String=("\u{001B}[0;92m  .XMMMMMMMMMMMMMMMMMMMMMMMMMMMMk  \u{001B}[0m")
let apple14:String=("\u{001B}[0;92m   .XMMMMMMMMMMMMMMMMMMMMMMMMK.    \u{001B}[0m")
let apple15:String=("\u{001B}[0;92m     kMMMMMMMMMMMMMMMMMMMMMMd      \u{001B}[0m")
let apple16:String=("\u{001B}[0;92m      ;KMMMMMMMWXXWMMMMMMMk.       \u{001B}[0m")
let apple17:String=("\u{001B}[0;92m        .cooc,.    .,coo:.         \u{001B}[0m")
let apple18:String=("\u{001B}[0;92m                                   \u{001B}[0m")

func executeCommand(_ command: String) -> String? {
    let process = Process()
    process.executableURL = URL(fileURLWithPath: "/bin/bash") /* uses bash for compatibility reasons */
    process.arguments = ["-c", command]
    
    let outputPipe = Pipe()
    process.standardOutput = outputPipe
    
    do {
        try process.run()
        let data = outputPipe.fileHandleForReading.readDataToEndOfFile()
        if let output = String(data: data, encoding: .utf8)?.trimmingCharacters(in: .whitespacesAndNewlines) {
            return output
        }
    } catch {
        print("Error executing command: \(error.localizedDescription)")
    }
    
    return nil
}

func printCommandOutput(_ command: String) {
    if let output = executeCommand(command) {
        print(output)
    }
}

print(apple01)

if let command = executeCommand("echo $USER@$(hostname)") {
    print("\(apple02)\(command)")
}

// placeholder, adaptable line might be added in the future
print(apple03 + "-----------------------------")

if let command = executeCommand("sw_vers -productName && sw_vers -productVersion ") {
    print("\(apple04)OS:         \(command.replacingOccurrences(of: "\n", with: " "))"
)
if let command = executeCommand("sysctl -n hw.model") {
    print("\(apple05)Host:       \(command)")
}
if let command = executeCommand("uname -r") {
    print("\(apple06)Kernel:     Darwin v\(command)")
}
// placeholder
if let command = executeCommand("system_profiler SPSoftwareDataType | grep \"Time since boot\" | sed 's/Time since boot:\\s*//'") {
    print("\(apple07)Uptime:     \(command)")
}
// produces major lag
if let command = executeCommand("brew list --versions | wc -l") {
    print("\(apple08)Packages:   \(command)")
}
if let command = executeCommand("echo $SHELL") {
    print("\(apple09)Shell:      \(command)")
}
// might lag
if let command = executeCommand("system_profiler SPDisplaysDataType | grep Resolution") {
    print("\(apple10)\(command)")
} 
// placeholder
if let command = executeCommand("echo Aqua") {
    print("\(apple11)DE:         \(command)")
}
// placeholder
if let command = executeCommand("echo Aqua") {
    print("\(apple12)WM:         \(command)")
}
if let command = executeCommand("echo $TERM_PROGRAM") {
    print("\(apple13)Terminal:   \(command)")
}
if let command = executeCommand("sysctl -n machdep.cpu.brand_string") {
    print("\(apple14)CPU:        \(command)")
}
// "cpu model" is used instead of "gpu model", "gpu model" does not exist
if let command = executeCommand("sysctl -n machdep.cpu.brand_string") {
    print("\(apple15)GPU:        \(command)")
}
// system ram
if let command = executeCommand("system_profiler SPHardwareDataType | grep \"Memory:\" | awk '{print $2}' | sed 's/GB//g'") {
    if let command2 = executeCommand("sysctl -n hw.usermem | awk '{printf(\"%d\", $1 / 1024 / 1024)}'") {
        print("\(apple16)Memory:     \(command2) MiB / \(Int(command)! * 1024) MiB")
    }
}

print(apple17)
print(apple18)
}
