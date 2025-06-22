# MCPComputerUse - C# Computer Use MCP Server

A native C# implementation of a Computer Use MCP Server for Windows, providing superior automation capabilities through direct Windows API integration.

## 🚀 Features

- **Screenshot Capture**: Multi-monitor support with flexible targeting
- **Window Management**: Complete window enumeration and control
- **Mouse Automation**: Precise clicking, moving, and scrolling
- **Keyboard Automation**: Text typing and key combinations
- **Macro System**: Complex automation sequences
- **MCP Protocol**: Full compliance with MCP specification
- **High Performance**: Native Windows API integration
- **Zero Dependencies**: Self-contained executable

## 🛠️ Tools Available

### Screenshot Tools
- `computer-use:take_screenshot` - Take screenshots with flexible targeting
- Support for multi-monitor setups
- Window-specific captures
- Configurable output formats

### Window Management
- `computer-use:list_windows` - List all visible windows
- `computer-use:get_active_window` - Get currently active window info
- `computer-use:focus_window` - Focus a window by ID or name
- `computer-use:manage_window` - Minimize, maximize, restore windows

### Input Automation
- `computer-use:mouse_click` - Click at coordinates with button options
- `computer-use:mouse_move` - Move mouse to coordinates
- `computer-use:type_text` - Type text with Unicode support
- `computer-use:press_key` - Press keys with modifier support
- `computer-use:scroll` - Scroll at specific coordinates

### Macro System
- `computer-use:run_macro` - Execute complex automation sequences
- Support for all automation actions
- Error handling and reporting
- Configurable timing

### System Info
- `computer-use:get_server_capabilities` - Get server capabilities and status

## 🏗️ Architecture

### Core Components
- **MCPComputerUse.exe** - Main console application with MCP protocol
- **WindowsAutomation.dll** - Native Windows API automation library
- **MCPProtocol.dll** - MCP specification implementation

### Technology Stack
- **.NET 8.0** - Latest LTS framework
- **Windows Forms** - For screen capture support
- **System.Drawing** - Image manipulation
- **Newtonsoft.Json** - JSON serialization
- **Native Windows APIs** - Direct P/Invoke integration

## 📦 Installation

### Prerequisites
- Windows 10 or Windows 11
- No additional runtime required (self-contained)

### Download
1. Download the latest release from GitHub
2. Extract `MCPComputerUse.exe` to your desired location
3. No installation required - single executable file

### Claude Desktop Integration
Add to your Claude Desktop configuration:

```json
{
  "mcpServers": {
    "computer-use": {
      "command": "c:/path/to/MCPComputerUse.exe",
      "args": []
    }
  }
}
```

## 🔧 Building from Source

### Requirements
- Visual Studio 2022 or VS Code with C# extension
- .NET 8.0 SDK
- Windows 10/11 development machine

### Build Steps
```bash
# Clone the repository
git clone <repository-url>
cd MCPComputerUse

# Restore dependencies
dotnet restore

# Build solution
dotnet build --configuration Release

# Publish self-contained executable
dotnet publish src/MCPComputerUse -c Release -r win-x64 --self-contained -o ./publish
```

The resulting executable will be in the `./publish` folder.

## 📖 Usage Examples

### Taking Screenshots
```json
{
  "method": "tools/call",
  "params": {
    "name": "computer-use:take_screenshot",
    "arguments": {
      "target": "screen",
      "filename": "desktop_capture"
    }
  }
}
```

### Automating Mouse Clicks
```json
{
  "method": "tools/call", 
  "params": {
    "name": "computer-use:mouse_click",
    "arguments": {
      "x": 500,
      "y": 300,
      "button": "left",
      "clicks": 2
    }
  }
}
```

### Running Macros
```json
{
  "method": "tools/call",
  "params": {
    "name": "computer-use:run_macro",
    "arguments": {
      "commands": [
        {
          "action": "click",
          "x": 100,
          "y": 100
        },
        {
          "action": "type",
          "text": "Hello World"
        },
        {
          "action": "key",
          "key": "enter"
        }
      ]
    }
  }
}
```

## 🔍 Troubleshooting

### Common Issues

**Permission Errors**
- Ensure the executable has permission to capture screens
- Some applications may require running as administrator

**Window Focus Issues**
- UAC-protected applications may not respond to focus commands
- Try using window IDs instead of window titles for better reliability

**Screenshot Capture Problems**
- Check display index for multi-monitor setups
- Verify target window exists and is visible

### Logging
The application logs to console output. Use the following log levels:
- Information: General operation status
- Debug: Detailed execution information  
- Error: Error conditions and failures

## 🚀 Performance

### Benchmarks
- Screenshot capture: <100ms for 1920x1080
- Window enumeration: <50ms for 100 windows
- Mouse/keyboard actions: <10ms per action
- Macro execution: 100ms between commands (configurable)

### Memory Usage
- Base memory: <50MB
- Per screenshot: <10MB temporary
- Window caching: <5MB

## 🔒 Security

### Permissions
- No elevation required for basic operations
- Screen capture permissions may be requested by Windows
- Input simulation works with most applications

### Safety Features
- Coordinate validation prevents out-of-bounds operations
- Rate limiting prevents input flooding
- Emergency stop sequences available

## 🤝 Contributing

Contributions are welcome! Please follow these guidelines:

1. Fork the repository
2. Create a feature branch
3. Write tests for new functionality
4. Ensure all tests pass
5. Submit a pull request

### Development Setup
```bash
# Clone your fork
git clone <your-fork-url>
cd MCPComputerUse

# Install dependencies
dotnet restore

# Run tests
dotnet test

# Start development
code .
```

## 📋 Roadmap

### Upcoming Features
- **OCR Integration** - Text recognition from screenshots
- **Image Matching** - Find UI elements by template
- **Macro Recording** - Record user actions automatically
- **Plugin System** - Extensible architecture
- **UI Automation** - Windows accessibility API integration

### Performance Improvements
- **Async Operations** - Better responsiveness
- **Caching** - Reduced API calls
- **Optimization** - Faster screenshot capture

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Microsoft for the .NET platform
- Anthropic for the MCP specification
- The open-source community for inspiration and libraries

## 📞 Support

For support and questions:
- Create an issue on GitHub
- Check the troubleshooting guide
- Review existing issues and discussions

---

**Built with ❤️ for the Windows automation community**
