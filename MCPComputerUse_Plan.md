# MCPComputerUse - C# Computer Use MCP Server

## 🎯 Project Overview

A native C# implementation of a Computer Use MCP Server for Windows, providing superior automation capabilities through direct Windows API integration. This replaces the Node.js version with a more reliable, performant, and maintainable solution.

## 🏗️ Architecture Plan

### **Core Components**

#### 1. **MCPComputerUse.exe** (Main Console Application)
- MCP Protocol implementation
- JSON-RPC communication via stdio
- Tool registry and dispatcher
- Error handling and logging

#### 2. **WindowsAutomation.dll** (Automation Library)
- Native Windows API wrappers
- Screenshot capture
- Mouse and keyboard control
- Window management
- Macro execution engine

#### 3. **MCPProtocol.dll** (MCP Implementation)
- MCP specification compliance
- Tool registration system
- Request/response handling
- Type-safe tool definitions

## 📁 Project Structure

```
MCPComputerUse/
├── src/
│   ├── MCPComputerUse/                    # Main console application
│   │   ├── Program.cs                     # Entry point and MCP server
│   │   ├── ToolRegistry.cs                # Tool registration and dispatch
│   │   ├── MCPServer.cs                   # MCP protocol implementation
│   │   └── MCPComputerUse.csproj          # Project file
│   │
│   ├── WindowsAutomation/                 # Automation library
│   │   ├── ScreenCapture/
│   │   │   ├── ScreenshotService.cs       # Multi-monitor screenshots
│   │   │   ├── WindowCapture.cs           # Window-specific captures
│   │   │   └── DisplayManager.cs          # Monitor enumeration
│   │   │
│   │   ├── Input/
│   │   │   ├── MouseController.cs         # Mouse automation
│   │   │   ├── KeyboardController.cs      # Keyboard automation
│   │   │   └── InputSimulator.cs          # Combined input control
│   │   │
│   │   ├── WindowManagement/
│   │   │   ├── WindowManager.cs           # Window enumeration/control
│   │   │   ├── WindowInfo.cs              # Window data structures
│   │   │   └── ProcessManager.cs          # Process information
│   │   │
│   │   ├── Macros/
│   │   │   ├── MacroEngine.cs             # Macro execution
│   │   │   ├── MacroCommand.cs            # Command definitions
│   │   │   └── MacroRecorder.cs           # Future: Record macros
│   │   │
│   │   ├── Native/
│   │   │   ├── User32.cs                  # User32.dll imports
│   │   │   ├── Gdi32.cs                   # GDI32.dll imports
│   │   │   ├── Kernel32.cs                # Kernel32.dll imports
│   │   │   └── Structures.cs              # Native structures
│   │   │
│   │   └── WindowsAutomation.csproj       # Library project file
│   │
│   └── MCPProtocol/                       # MCP implementation
│       ├── IMCPServer.cs                  # MCP server interface
│       ├── MCPTool.cs                     # Tool base class
│       ├── MCPRequest.cs                  # Request/response models
│       ├── MCPResponse.cs
│       ├── StdioTransport.cs              # Stdio communication
│       └── MCPProtocol.csproj             # Protocol library
│
├── tools/                                 # Tool implementations
│   ├── ScreenshotTool.cs                  # Screenshot functionality
│   ├── WindowManagementTools.cs          # Window operations
│   ├── MouseAutomationTools.cs           # Mouse control
│   ├── KeyboardAutomationTools.cs        # Keyboard control
│   ├── MacroTools.cs                     # Macro execution
│   └── SystemInfoTools.cs                # System information
│
├── tests/
│   ├── MCPComputerUse.Tests/             # Unit tests
│   ├── WindowsAutomation.Tests/          # Automation tests
│   └── IntegrationTests/                 # End-to-end tests
│
├── docs/
│   ├── API.md                            # Tool documentation
│   ├── Configuration.md                 # Setup instructions
│   └── Examples.md                       # Usage examples
│
├── scripts/
│   ├── build.bat                         # Build script
│   ├── publish.bat                       # Publishing script
│   └── install.bat                       # Installation script
│
├── MCPComputerUse.sln                    # Solution file
├── README.md                             # Project documentation
└── LICENSE                               # MIT license
```

## 🛠️ Implementation Plan

### **Phase 1: Core Infrastructure** (Week 1)

#### **1.1 Solution Setup**
- [ ] Create Visual Studio solution
- [ ] Set up project structure
- [ ] Configure build system
- [ ] Add necessary NuGet packages

#### **1.2 MCP Protocol Implementation**
```csharp
// MCPServer.cs - Core MCP server
public class MCPServer
{
    private readonly IStdioTransport _transport;
    private readonly ToolRegistry _tools;
    
    public async Task StartAsync()
    {
        // MCP initialization
        // Tool registration
        // Message loop
    }
}

// MCPTool.cs - Base tool class
public abstract class MCPTool
{
    public abstract string Name { get; }
    public abstract string Description { get; }
    public abstract MCPToolSchema Schema { get; }
    public abstract Task<MCPResponse> ExecuteAsync(MCPRequest request);
}
```

#### **1.3 Native API Foundations**
```csharp
// User32.cs - Essential Windows APIs
public static class User32
{
    [DllImport("user32.dll")]
    public static extern bool SetCursorPos(int x, int y);
    
    [DllImport("user32.dll")]
    public static extern void mouse_event(uint dwFlags, uint dx, uint dy, uint dwData, UIntPtr dwExtraInfo);
    
    [DllImport("user32.dll")]
    public static extern IntPtr GetForegroundWindow();
    
    [DllImport("user32.dll")]
    public static extern bool EnumWindows(EnumWindowsProc lpEnumFunc, IntPtr lParam);
}
```

### **Phase 2: Screenshot System** (Week 1-2)

#### **2.1 Multi-Monitor Screenshot**
```csharp
public class ScreenshotService
{
    public byte[] CaptureScreen(int displayIndex = 0)
    {
        var screen = Screen.AllScreens[displayIndex];
        using var bitmap = new Bitmap(screen.Bounds.Width, screen.Bounds.Height);
        using var graphics = Graphics.FromImage(bitmap);
        
        graphics.CopyFromScreen(screen.Bounds.X, screen.Bounds.Y, 0, 0, screen.Bounds.Size);
        
        using var stream = new MemoryStream();
        bitmap.Save(stream, ImageFormat.Png);
        return stream.ToArray();
    }
}
```

#### **2.2 Window-Specific Capture**
```csharp
public class WindowCapture
{
    public byte[] CaptureWindow(IntPtr hWnd)
    {
        GetWindowRect(hWnd, out var rect);
        var width = rect.Right - rect.Left;
        var height = rect.Bottom - rect.Top;
        
        using var bitmap = new Bitmap(width, height);
        using var graphics = Graphics.FromImage(bitmap);
        
        var hdc = graphics.GetHdc();
        PrintWindow(hWnd, hdc, 0);
        graphics.ReleaseHdc(hdc);
        
        // Return as PNG bytes
    }
}
```

### **Phase 3: Input Automation** (Week 2)

#### **3.1 Mouse Controller**
```csharp
public class MouseController
{
    public void MoveTo(int x, int y) => SetCursorPos(x, y);
    
    public void Click(MouseButton button = MouseButton.Left, int clicks = 1)
    {
        uint downFlag = button == MouseButton.Left ? MOUSEEVENTF_LEFTDOWN : MOUSEEVENTF_RIGHTDOWN;
        uint upFlag = button == MouseButton.Left ? MOUSEEVENTF_LEFTUP : MOUSEEVENTF_RIGHTUP;
        
        for (int i = 0; i < clicks; i++)
        {
            mouse_event(downFlag, 0, 0, 0, UIntPtr.Zero);
            mouse_event(upFlag, 0, 0, 0, UIntPtr.Zero);
        }
    }
    
    public void Scroll(int delta, int x, int y)
    {
        SetCursorPos(x, y);
        mouse_event(MOUSEEVENTF_WHEEL, 0, 0, (uint)delta, UIntPtr.Zero);
    }
}
```

#### **3.2 Keyboard Controller**
```csharp
public class KeyboardController
{
    public void TypeText(string text)
    {
        foreach (char c in text)
        {
            SendChar(c);
        }
    }
    
    public void PressKey(VirtualKeyCode key, params VirtualKeyCode[] modifiers)
    {
        // Press modifiers
        foreach (var mod in modifiers)
            keybd_event((byte)mod, 0, 0, UIntPtr.Zero);
            
        // Press main key
        keybd_event((byte)key, 0, 0, UIntPtr.Zero);
        keybd_event((byte)key, 0, KEYEVENTF_KEYUP, UIntPtr.Zero);
        
        // Release modifiers
        foreach (var mod in modifiers.Reverse())
            keybd_event((byte)mod, 0, KEYEVENTF_KEYUP, UIntPtr.Zero);
    }
}
```

### **Phase 4: Window Management** (Week 2-3)

#### **4.1 Window Enumeration**
```csharp
public class WindowManager
{
    public List<WindowInfo> GetAllWindows(bool includeHidden = false)
    {
        var windows = new List<WindowInfo>();
        
        EnumWindows((hWnd, lParam) =>
        {
            if (!includeHidden && !IsWindowVisible(hWnd))
                return true;
                
            var info = new WindowInfo
            {
                Handle = hWnd,
                Title = GetWindowTitle(hWnd),
                ProcessName = GetProcessName(hWnd),
                Bounds = GetWindowBounds(hWnd),
                IsVisible = IsWindowVisible(hWnd),
                IsMinimized = IsIconic(hWnd)
            };
            
            windows.Add(info);
            return true;
        }, IntPtr.Zero);
        
        return windows;
    }
}
```

### **Phase 5: Tool Implementation** (Week 3)

#### **5.1 Screenshot Tools**
```csharp
public class ScreenshotTool : MCPTool
{
    public override string Name => "take_screenshot";
    public override string Description => "Take screenshots with flexible targeting";
    
    public override async Task<MCPResponse> ExecuteAsync(MCPRequest request)
    {
        var args = request.Arguments;
        var target = args.GetValueOrDefault("target", "screen");
        var filename = args.GetValueOrDefault("filename", "screenshot");
        
        byte[] imageData = target switch
        {
            "active_window" => await CaptureActiveWindow(),
            "window" => await CaptureSpecificWindow(args),
            _ => await CaptureScreen(args)
        };
        
        var filepath = await SaveScreenshot(imageData, filename);
        
        return new MCPResponse
        {
            Content = new[] { new { type = "text", text = $"Screenshot saved: {filepath}" } }
        };
    }
}
```

### **Phase 6: Macro System** (Week 3-4)

#### **6.1 Macro Engine**
```csharp
public class MacroEngine
{
    private readonly MouseController _mouse;
    private readonly KeyboardController _keyboard;
    private readonly ScreenshotService _screenshot;
    
    public async Task<MacroResult> ExecuteAsync(MacroCommand[] commands, string name = null)
    {
        var results = new List<string>();
        
        foreach (var (command, index) in commands.Select((c, i) => (c, i)))
        {
            try
            {
                var result = await ExecuteCommand(command);
                results.Add($"{index + 1}. {result}");
                
                // Default delay between commands
                await Task.Delay(100);
            }
            catch (Exception ex)
            {
                results.Add($"{index + 1}. Error: {ex.Message}");
            }
        }
        
        return new MacroResult { Results = results };
    }
}
```

### **Phase 7: Testing & Polish** (Week 4)

#### **7.1 Integration Tests**
- [ ] Test all MCP tools
- [ ] Verify multi-monitor support
- [ ] Test complex macros
- [ ] Performance benchmarking

#### **7.2 Documentation**
- [ ] Complete API documentation
- [ ] Usage examples
- [ ] Configuration guide
- [ ] Troubleshooting

## 📋 Tool Specifications

### **1. Screenshot Tools**

#### `take_screenshot`
- **Multi-monitor support**: Specify display index
- **Window targeting**: Active window, specific window by handle/title
- **Format options**: PNG, JPEG, BMP
- **Quality settings**: Compression levels

#### `list_displays`
- **Monitor enumeration**: All connected displays
- **Display properties**: Resolution, position, primary status
- **DPI awareness**: Handle high-DPI displays

### **2. Window Management**

#### `list_windows`
- **Complete enumeration**: All visible/hidden windows
- **Rich metadata**: Title, process, bounds, state
- **Filtering options**: By process, visibility, etc.

#### `focus_window`
- **Multiple targeting**: By handle, title, process name
- **Smart matching**: Partial title matching
- **State restoration**: Restore minimized windows

### **3. Input Automation**

#### `mouse_click`
- **Button support**: Left, right, middle, X1, X2
- **Click types**: Single, double, hold, release
- **Coordinate systems**: Screen, window-relative

#### `type_text`
- **Unicode support**: Full international character set
- **Formatting**: Handle newlines, tabs, special chars
- **Speed control**: Configurable typing speed

#### `press_key`
- **Virtual key codes**: Complete VK_* support
- **Modifier combinations**: Ctrl, Alt, Shift, Win
- **Key sequences**: Multiple key combinations

### **4. Macro System**

#### `run_macro`
- **Command types**: All automation actions
- **Flow control**: Loops, conditions, branching
- **Error handling**: Continue on error options
- **Timing control**: Delays, synchronization

## 🔧 Technical Requirements

### **Development Environment**
- **Visual Studio 2022** (Community or higher)
- **.NET 8.0** runtime and SDK
- **Windows 10/11** development machine
- **Git** for version control

### **Dependencies**
- **System.Drawing** - Image manipulation
- **Newtonsoft.Json** - JSON serialization
- **Microsoft.Extensions.Logging** - Logging framework
- **Microsoft.Extensions.Hosting** - Service hosting

### **Target Framework**
- **.NET 8.0** - Latest LTS version
- **Windows-specific** - No cross-platform requirements
- **Self-contained deployment** - Include runtime

## 🚀 Deployment Strategy

### **Build Configuration**
```xml
<PropertyGroup>
  <OutputType>Exe</OutputType>
  <TargetFramework>net8.0-windows</TargetFramework>
  <PublishSingleFile>true</PublishSingleFile>
  <SelfContained>true</SelfContained>
  <RuntimeIdentifier>win-x64</RuntimeIdentifier>
  <PublishTrimmed>true</PublishTrimmed>
</PropertyGroup>
```

### **Publishing**
```bash
# Create self-contained executable
dotnet publish -c Release -r win-x64 --self-contained

# Result: Single MCPComputerUse.exe file (~30MB)
```

### **Claude Desktop Integration**
```json
{
  "mcpServers": {
    "computer-use": {
      "command": "c:/LLM/Projects/ClaudeTest/MCPComputerUse/bin/MCPComputerUse.exe",
      "args": []
    }
  }
}
```

## 📊 Performance Targets

### **Benchmarks**
- **Screenshot capture**: < 100ms for 1920x1080
- **Window enumeration**: < 50ms for 100 windows
- **Mouse/keyboard actions**: < 10ms per action
- **Macro execution**: 100ms between commands (configurable)

### **Memory Usage**
- **Base memory**: < 50MB
- **Per screenshot**: < 10MB temporary
- **Window caching**: < 5MB

### **File Size**
- **Executable**: ~30MB (self-contained)
- **No dependencies**: Zero additional files needed

## 🔒 Security Considerations

### **Permissions**
- **No elevation required**: Standard user permissions
- **Screen capture**: May require display capture permissions
- **Input simulation**: Works with UAC-protected apps

### **Safety Features**
- **Coordinate validation**: Prevent out-of-bounds clicks
- **Rate limiting**: Prevent input flooding
- **Emergency stops**: Ctrl+Alt+Esc abort sequences

## 🎯 Success Criteria

### **Functional Requirements**
- [ ] All 10+ automation tools working
- [ ] Multi-monitor screenshot support
- [ ] Reliable window management
- [ ] Smooth mouse/keyboard automation
- [ ] Complex macro execution
- [ ] MCP protocol compliance

### **Quality Requirements**
- [ ] Zero installation dependencies
- [ ] < 100ms response times
- [ ] Comprehensive error handling
- [ ] Full Unicode support
- [ ] Memory efficient operation

### **Deployment Requirements**
- [ ] Single executable file
- [ ] Works on Windows 10/11
- [ ] No admin rights required
- [ ] Easy Claude Desktop integration

## 🚧 Risk Mitigation

### **Technical Risks**
- **MCP protocol changes**: Version compatibility
- **Windows API changes**: Regular testing on updates
- **Performance issues**: Benchmarking and optimization

### **Mitigation Strategies**
- **Extensive testing**: Multiple Windows versions
- **Fallback mechanisms**: Alternative API approaches
- **Performance monitoring**: Built-in profiling

## 📈 Future Enhancements

### **Phase 2 Features**
- [ ] **OCR integration**: Text recognition from screenshots
- [ ] **Image matching**: Find UI elements by template
- [ ] **Macro recording**: Record user actions
- [ ] **Scripting support**: C# script execution
- [ ] **Plugin system**: Extensible architecture

### **Advanced Automation**
- [ ] **UI Automation**: Windows accessibility APIs
- [ ] **Process automation**: Application lifecycle
- [ ] **Network automation**: HTTP requests, API calls
- [ ] **File operations**: Advanced file manipulation

---

## 🎯 Next Steps

1. **Create Visual Studio solution**
2. **Set up project structure**
3. **Implement MCP protocol foundation**
4. **Build core Windows automation**
5. **Integrate and test tools**
6. **Package for deployment**

**Estimated Timeline: 3-4 weeks for full implementation**

This C# implementation will be significantly more reliable, performant, and maintainable than the Node.js version, while providing superior Windows integration and automation capabilities.