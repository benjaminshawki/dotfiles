<!-- LTeX: language=nl -->

# Rust en IDE installeren op windows (Week 7)

Alles wordt uitgevoerd in de PowerShell

## git
Mocht je nog geen git hebben geïnstalleerd dan kun je dit doen met het commando
```powershell
PS > winget install git
```

## ms build tools
```powershell
PS > winget install --id Microsoft.VisualStudio.2022.BuildTools
```

Open Visual Studio installer -> modify build tools -> individual components -> selecteer "MSVC v143 - VS 2022 C++ x64/x86 build tools (Latest)", "Windows 11 SDK" en "C++ CMake tools for Windows"

Eventueel de computer opnieuw opstarten als hierom wordt gevraagd.

## Visual Studio Code

```powershell
PS > winget install --id Microsoft.VisualStudioCode
```

Installeer ook de Visual Studio Code extensies:

-    rust-analyzer
-    cortex-debug

## Rust zelf

```powershell
PS > winget install --id Rustlang.Rustup
```

# Embedded software installeren (Week 8)

## ARM Cross Compiler en GDB

```powershell
PS > winget install --id Arm.GnuArmEmbeddedToolchain
```

## cargo generate

```powershell
PS > cargo install cargo-generate
```
Dit zal cargo-generate installeren in de huidige toolchain.

Mocht dat commando niet werken kun je het ook handmatig doen:
Download laatste windows release van https://github.com/cargo-generate/cargo-generate/releases
Pak cargo-generate.exe uit naar ~\.rustup\toolchains\stable-x86_64-pc-windows-msvc\bin

## openocd

Download laatste windows versie van https://github.com/xpack-dev-tools/openocd-xpack/releases/
Pak ergens uit, voeg bin map toe aan pad. (tijdelijk met `PS> env:PATH += ';C:/mijn/pad/bin' `)

# Project importeren en debuggen

```powershell
PS > cargo generate --git https://bitbucket.org/HR_ELEKTRO/rts10_projects.git rust_quick_start
Project Name : <jouw_project_naam>
PS > rustup toolchain install nightly
PS > rustup default nightly
PS > rustup target add thumbv7em-none-eabihf
PS > code ./<jouw_project_naam>
```
In VS Code kun je direct op F5 drukken om het project te compileren en te debuggen.