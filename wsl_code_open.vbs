Option Explicit

Dim shell, targetDir, command, distroName
Set shell = CreateObject("WScript.Shell")

If WScript.Arguments.Count = 0 Then
  WScript.Quit 1
End If

distroName = GetDefaultDistro()
targetDir = WScript.Arguments(0)
targetDir = NormalizeWslPath(targetDir, distroName)
CreateObject("Shell.Application").ShellExecute "Code.exe", "--remote " & Quote("wsl+" & distroName) & " " & Quote(wslPath), "", "open", 0

Function GetDefaultDistro()
  Dim exec, output
  On Error Resume Next
  Set exec = shell.Exec("wsl.exe --list --quiet")
  If Err.Number <> 0 Then
    GetDefaultDistro = "Ubuntu"
    Exit Function
  End If
  output = exec.StdOut.ReadLine()
  If output = "" Then
    GetDefaultDistro = "Ubuntu"
  Else
    GetDefaultDistro = Trim(output)
  End If
End Function

Function Quote(value)
  Quote = Chr(34) & Replace(value, Chr(34), Chr(34) & Chr(34)) & Chr(34)
End Function

Function NormalizeWslPath(value, distro)
  Dim lowerValue, localhostRoot, dollarRoot, localhostPrefix, dollarPrefix, rest

  lowerValue = LCase(value)
  localhostRoot = "\\wsl.localhost\" & LCase(distro)
  dollarRoot = "\\wsl$\" & LCase(distro)
  localhostPrefix = localhostRoot & "\"
  dollarPrefix = dollarRoot & "\"

  If lowerValue = localhostRoot Or lowerValue = dollarRoot Then
    NormalizeWslPath = "/"
  ElseIf Left(lowerValue, Len(localhostPrefix)) = localhostPrefix Then
    rest = Mid(value, Len(localhostPrefix) + 1)
    NormalizeWslPath = "/" & Replace(rest, "\", "/")
  ElseIf Left(lowerValue, Len(dollarPrefix)) = dollarPrefix Then
    rest = Mid(value, Len(dollarPrefix) + 1)
    NormalizeWslPath = "/" & Replace(rest, "\", "/")
  Else
    NormalizeWslPath = value
  End If
End Function