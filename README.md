# WSL 右键菜单注册表脚本

Windows 右键菜单一键导入，批量添加 WSL 相关快捷操作。

## 文件说明

| 文件 | 功能 |
|------|------|
| `wsl_open_terminal.reg` | 右键文件夹 → "Open in WSL"（在 WSL 终端中打开） |
| `wsl_open_vscode.reg` | 右键文件夹 → "Open in WSL with VS Code"（在 WSL 中用 VS Code 打开） |
| `wsl_import_helper.bat` | 导入帮助说明 |

## 使用方法

把 `.reg` 文件复制到 Windows 上，双击即可合并到注册表；或命令行静默导入：

```bat
regedit /s wsl_open_terminal.reg
regedit /s wsl_open_vscode.reg
```

## 卸载

删除以下注册表项即可移除菜单：

```
HKEY_CLASSES_ROOT\Directory\shell\WSLTerminal
HKEY_CLASSES_ROOT\Directory\Background\shell\WSLTerminal
HKEY_CLASSES_ROOT\Directory\shell\WSLVSCode
HKEY_CLASSES_ROOT\Directory\Background\shell\WSLVSCode
```

## 前提

- 已安装 WSL（Windows Subsystem for Linux）
- VS Code 方式需要 WSL 内安装 `code` 命令（安装 [Remote - WSL](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-wsl) 扩展后会自动配置）