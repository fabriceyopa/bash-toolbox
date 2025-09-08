# Bash Utilities Repository

A collection of Bash scripts and Docker Compose configurations to streamline daily development tasks.

## 📁 Repository Structure

```
/
├── scripts/           # Bash utility scripts
│   └── select_java_version.sh
├── docker/            # Docker Compose files
└── README.md         # This file
```

## 🛠️ Scripts

### select_java_version.sh

An interactive Bash script that uses `fzf` and `sdkman` to search and select installed Java versions managed by SDKMAN, then sets the selected version as default.

#### Features

- 🔍 Fuzzy search through installed Java versions
- 🎯 Interactive selection with fzf
- ✅ Automatic SDKMAN initialization
- 🎨 Colored output for better UX
- ⚡ Quick version switching

#### Prerequisites

- [SDKMAN](https://sdkman.io/) installed
- [fzf](https://github.com/junegunn/fzf) installed
- Bash shell

#### Usage

```bash
# Make executable (first time only)
chmod +x scripts/select_java_version.sh

# Run the script
./scripts/select_java_version.sh
```

#### Example Output

```
Setting Java version 17.0.9-tem as default...
Successfully set Java 17.0.9-tem as default.
Current default Java version:
openjdk version "17.0.9" 2023-10-17
...
```

## 🐳 Docker Compose Files

_Coming soon - Docker Compose configurations for common development environments_

## 🚀 Quick Start

1. **Clone the repository**

   ```bash
   git clone <repository-url>
   cd bash-toolbox
   ```

## 📋 Prerequisites

- **Operating System**: macOS, Linux, or WSL
- **Shell**: Bash (version 4.0+ recommended)
- **Tools**:
  - SDKMAN for Java version management
  - fzf for fuzzy finding
  - Git for version control

## 🤝 Contributing

Feel free to contribute your own Bash scripts or Docker Compose files:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-script`)
3. Add your script with proper documentation
4. Test thoroughly
5. Submit a pull request

### Guidelines

- Include clear comments in scripts
- Add usage examples
- Test on multiple platforms when possible
- Follow Bash best practices

## 📄 License

Copyright (c) 2025 Fabrice Yopa. All rights reserved.

## 📞 Support

If you find these utilities helpful, consider:

- ⭐ Starring the repository
- 🐛 Reporting issues
- 💡 Suggesting improvements
- 🔀 Contributing your own scripts

---

_Built with ❤️ for developers by developers_
