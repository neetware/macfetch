import Foundation

let apple01:String=("                    'c.          ")
let apple02:String=("                 ,xNMM.          ")
let apple03:String=("               .OMMMMo           ")
let apple04:String=("               OMMM0,            ")
let apple05:String=("     .;loddo:' loolloddol;.      ")
let apple06:String=("   cKMMMMMMMMMMNWMMMMMMMMMM0:    ")
let apple07:String=(" .KMMMMMMMMMMMMMMMMMMMMMMMWd.    ")
let apple08:String=(" XMMMMMMMMMMMMMMMMMMMMMMMX.      ")
let apple09:String=(";MMMMMMMMMMMMMMMMMMMMMMMM:       ")
let apple10:String=(":MMMMMMMMMMMMMMMMMMMMMMMM:       ")
let apple11:String=(".MMMMMMMMMMMMMMMMMMMMMMMMX.      ")
let apple12:String=(" kMMMMMMMMMMMMMMMMMMMMMMMMWd.    ")
let apple13:String=(" .XMMMMMMMMMMMMMMMMMMMMMMMMMMk   ")
let apple14:String=("  .XMMMMMMMMMMMMMMMMMMMMMMMMK.   ")
let apple15:String=("    kMMMMMMMMMMMMMMMMMMMMMMd     ")
let apple16:String=("     ;KMMMMMMMWXXWMMMMMMMk.      ")
let apple17:String=("       .cooc,.    .,coo:.        ")
let apple18:String=("                                 ")

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
// placeholder
if let command = executeCommand("echo 1337MiB / 8192MiB ") {
    print("\(apple16)Memory:     \(command)")
}
print(apple17)
print(apple18)
}
