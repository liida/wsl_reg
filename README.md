# WSL 右键菜单

Windows 右键菜单一键导入，在文件夹右键菜单中添加 WSL 相关快捷操作。

## 文件说明

| 文件 | 功能 |
|------|------|
| `install.bat` | **一键安装（推荐）**：复制 VBS + 写入注册表 + 设置图标 |
| `uninstall.bat` | 一键卸载：删除注册表项 + VBS 脚本 |
| `wsl_open_terminal.reg` | 注册表脚本：右键 → "Open in WSL" |
| `wsl_open_vscode.reg` | 注册表脚本：右键 → "Open in WSL with VS Code" |
| `wsl_code_open.vbs` | VBS 辅助脚本：路径转换并启动 VS Code |

## 使用方法

### 安装

> **需要以管理员身份运行**（右键 → 以管理员身份运行），因为需要写入 `HKEY_CLASSES_ROOT` 注册表。

**推荐（图标 + 完整安装）：**

```bat
右键 install.bat → 以管理员身份运行
```

**仅注册表（无图标，可手动导入）：**

```bat
regedit /s wsl_open_terminal.reg
regedit /s wsl_open_vscode.reg
```

### 卸载

```bat
右键 uninstall.bat → 以管理员身份运行
```

## 前提条件

### WSL

已安装 WSL（Windows Subsystem for Linux），并至少有一个已安装的 Linux 发行版。

如果安装了多个发行版，确保已配置默认发行版（VBS 会自动检测并使用默认发行版）：

```bat
wsl --set-default <发行版名称>
```

### Visual Studio Code（仅 VS Code 菜单需要）

Windows 端安装 VS Code，并在 WSL 内安装 `code` 命令：

1. Windows 端安装 [VS Code](https://code.visualstudio.com/)
2. 安装 [Remote - WSL](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-wsl) 扩展
3. 在 VS Code 中按 `F1` 或 `Ctrl+Shift+P`，运行 `Remote-WSL: Install 'code' command in path`

验证：

```bash
# 在 WSL 中执行
code --version
```

如果以上步骤未生效，可手动创建软链：

```bash
# 替换 <用户名> 为你的 Windows 用户名
sudo ln -s "/mnt/c/Users/<用户名>/AppData/Local/Programs/Microsoft VS Code/bin/code" /usr/local/bin/code
```

### Windows Terminal（仅 "Open in WSL" 菜单需要）

建议安装 [Windows Terminal](https://apps.microsoft.com/detail/9n0dx20hk701)（Microsoft Store），并将它设为默认终端应用程序。这样每次右键 "Open in WSL" 会在同一个 WT 窗口的新标签页中打开，而不是弹出新窗口。

## 注意事项

- `install.bat` 会将 `wsl_code_open.vbs` 复制到 `%LOCALAPPDATA%\WSLTools\`
- VBS 自动检测默认 WSL 发行版名称，无需手动配置
- 如果从 `\\wsl$\...` 浏览 WSL 文件系统，VBS 会自动转换路径格式