# Bash Utilities Repository

A collection of Bash scripts and Docker Compose configurations to streamline daily development tasks.

## 📁 Repository Structure

```
/
├── scripts/           # Bash utility scripts
│   ├── get_first_commit.sh
│   └── select_java_version.sh
├── docker/            # Docker Compose files
└── README.md         # This file
```

## 🛠️ Scripts

### select_java_version.sh

An interactive Bash script that uses `fzf` and `sdkman` to search and select installed Java versions managed by SDKMAN, then sets the selected version as default.

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

### get_first_commit.sh

A Bash script that retrieves the first commit hash from a Git repository and generates a GitHub link if the remote is GitHub. Supports both local paths and GitHub URLs.

#### Prerequisites

- Git installed
- Bash shell

#### Usage

```bash
# Make executable (first time only)
chmod +x scripts/get_first_commit.sh

# Run with current directory
./scripts/get_first_commit.sh

# Run with specific path
./scripts/get_first_commit.sh /path/to/git/repo

# Run with GitHub URL
./scripts/get_first_commit.sh https://github.com/user/repo
./scripts/get_first_commit.sh git@github.com:user/repo.git
```

#### Installation (System-wide)

```bash
sudo cp scripts/get_first_commit.sh /usr/local/bin/get_first_commit
sudo chmod +x /usr/local/bin/get_first_commit
# Then use: get_first_commit [path|url]
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
