#!/bin/bash

# Vim/Neovim Configuration Setup Script
# This script sets up the complete vim configuration on a new computer

set -e  # Exit on any error

echo "🚀 Setting up Vim/Neovim configuration..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Detect OS
detect_os() {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        OS="linux"
        if command -v apt-get &> /dev/null; then
            DISTRO="debian"
        elif command -v yum &> /dev/null; then
            DISTRO="redhat"
        elif command -v pacman &> /dev/null; then
            DISTRO="arch"
        fi
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        OS="macos"
    else
        print_error "Unsupported OS: $OSTYPE"
        exit 1
    fi
    print_status "Detected OS: $OS"
}

# Install dependencies
install_dependencies() {
    print_status "Installing dependencies..."
    
    case $OS in
        "linux")
            case $DISTRO in
                "debian")
                    sudo apt-get update
                    sudo apt-get install -y git curl build-essential nodejs npm python3 python3-pip ripgrep fzf
                    ;;
                "redhat")
                    sudo yum update -y
                    sudo yum install -y git curl gcc gcc-c++ make nodejs npm python3 python3-pip ripgrep fzf
                    ;;
                "arch")
                    sudo pacman -Sy --noconfirm git curl base-devel nodejs npm python python-pip ripgrep fzf
                    ;;
            esac
            ;;
        "macos")
            if ! command -v brew &> /dev/null; then
                print_status "Installing Homebrew..."
                /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
            fi
            brew install git curl node python3 ripgrep fzf
            ;;
    esac
    
    print_success "Dependencies installed"
}

# Install Neovim
install_neovim() {
    if command -v nvim &> /dev/null; then
        print_warning "Neovim already installed, skipping..."
        return
    fi
    
    print_status "Installing Neovim..."
    
    case $OS in
        "linux")
            case $DISTRO in
                "debian")
                    sudo apt-get install -y neovim
                    ;;
                "redhat")
                    sudo yum install -y neovim
                    ;;
                "arch")
                    sudo pacman -S --noconfirm neovim
                    ;;
            esac
            ;;
        "macos")
            brew install neovim
            ;;
    esac
    
    print_success "Neovim installed"
}

# Install vim-plug
install_vim_plug() {
    print_status "Installing vim-plug..."
    
    # For Neovim
    if [ ! -f "$HOME/.local/share/nvim/site/autoload/plug.vim" ]; then
        sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
        print_success "vim-plug installed for Neovim"
    else
        print_warning "vim-plug already installed for Neovim"
    fi
    
    # For Vim
    if [ ! -f "$HOME/.vim/autoload/plug.vim" ]; then
        curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        print_success "vim-plug installed for Vim"
    else
        print_warning "vim-plug already installed for Vim"
    fi
}

# Create necessary directories
create_directories() {
    print_status "Creating necessary directories..."
    
    mkdir -p ~/.config/nvim
    mkdir -p ~/.vim/plugged
    mkdir -p ~/.local/share/nvim/plugged
    
    print_success "Directories created"
}

# Backup existing configurations
backup_configs() {
    print_status "Backing up existing configurations..."
    
    BACKUP_DIR="$HOME/vim_config_backup_$(date +%Y%m%d_%H%M%S)"
    mkdir -p "$BACKUP_DIR"
    
    if [ -f "$HOME/.config/nvim/init.vim" ]; then
        mv "$HOME/.config/nvim/init.vim" "$BACKUP_DIR/init.vim"
        print_status "Backed up existing init.vim"
    fi
    
    if [ -f "$HOME/.vimrc" ]; then
        mv "$HOME/.vimrc" "$BACKUP_DIR/.vimrc"
        print_status "Backed up existing .vimrc"
    fi
    
    print_success "Configurations backed up to $BACKUP_DIR"
}

# Copy configuration files
copy_configs() {
    print_status "Copying configuration files..."
    
    # Get the directory where this script is located
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    
    # Copy init.vim to Neovim config
    if [ -f "$SCRIPT_DIR/init.vim" ]; then
        cp "$SCRIPT_DIR/init.vim" "$HOME/.config/nvim/init.vim"
        print_success "init.vim copied to Neovim config"
    else
        print_error "init.vim not found in script directory"
        exit 1
    fi
    
    # Copy .vimrc to home directory (if it exists and is different)
    if [ -f "$SCRIPT_DIR/.vimrc" ] && ! cmp -s "$SCRIPT_DIR/init.vim" "$SCRIPT_DIR/.vimrc"; then
        cp "$SCRIPT_DIR/.vimrc" "$HOME/.vimrc"
        print_success ".vimrc copied to home directory"
    fi
    
    print_success "Configuration files copied"
}

# Install plugins
install_plugins() {
    print_status "Installing plugins..."
    
    # Install plugins for Neovim
    if command -v nvim &> /dev/null; then
        print_status "Installing plugins for Neovim..."
        nvim --headless -c 'PlugInstall' -c 'qa' || {
            print_warning "Some plugins may not have installed correctly"
            print_status "You can run 'nvim +PlugInstall +qall' manually to complete installation"
        }
        print_success "Neovim plugins installation completed"
    fi
    
    # Install plugins for Vim
    if command -v vim &> /dev/null; then
        print_status "Installing plugins for Vim..."
        vim --headless -c 'PlugInstall' -c 'qa' || {
            print_warning "Some plugins may not have installed correctly"
            print_status "You can run 'vim +PlugInstall +qall' manually to complete installation"
        }
        print_success "Vim plugins installation completed"
    fi
}

# Install additional tools
install_additional_tools() {
    print_status "Installing additional tools..."
    
    # Install Python dependencies for some plugins
    if command -v pip3 &> /dev/null; then
        pip3 install --user pynvim
        print_success "Python neovim package installed"
    fi
    
    # Install npm dependencies
    if command -v npm &> /dev/null; then
        npm install -g eslint prettier
        print_success "npm packages installed"
    fi
    
    # Setup FZF
    if [ -f ~/.fzf/install ]; then
        ~/.fzf/install --all
        print_success "FZF setup completed"
    fi
}

# Create aliases
create_aliases() {
    print_status "Creating aliases..."
    
    ALIAS_FILE="$HOME/.vim_aliases"
    cat > "$ALIAS_FILE" << 'EOF'
# Vim/Neovim aliases
alias vim='nvim'
alias vi='nvim'
alias v='nvim'
EOF
    
    # Add to .bashrc if not already present
    if ! grep -q "source $ALIAS_FILE" "$HOME/.bashrc" 2>/dev/null; then
        echo "source $ALIAS_FILE" >> "$HOME/.bashrc"
    fi
    
    # Add to .zshrc if not already present
    if ! grep -q "source $ALIAS_FILE" "$HOME/.zshrc" 2>/dev/null; then
        echo "source $ALIAS_FILE" >> "$HOME/.zshrc"
    fi
    
    print_success "Aliases created"
}

# Final setup and verification
final_setup() {
    print_status "Performing final setup..."
    
    # Create a simple test file to verify installation
    echo "let g:setup_complete = 1" > "$HOME/.config/nvim/setup_complete.vim"
    
    print_success "Setup completed!"
}

# Main execution
main() {
    print_status "Starting Vim/Neovim configuration setup..."
    
    detect_os
    install_dependencies
    install_neovim
    install_vim_plug
    create_directories
    backup_configs
    copy_configs
    install_plugins
    install_additional_tools
    create_aliases
    final_setup
    
    echo ""
    echo "🎉 Setup completed successfully!"
    echo ""
    echo "📋 Next steps:"
    echo "1. Restart your terminal or run: source ~/.bashrc (or ~/.zshrc)"
    echo "2. Open Neovim: nvim"
    echo "3. If any plugins didn't install correctly, run: :PlugInstall"
    echo "4. Enjoy your configured Vim/Neovim!"
    echo ""
    echo "📁 Configuration location: ~/.config/nvim/init.vim"
    echo "📁 Plugin location: ~/.local/share/nvim/plugged"
    echo "📁 Backup location: $BACKUP_DIR"
    echo ""
    echo "✨ Key features installed:"
    echo "   • LSP support (Mason, nvim-lspconfig)"
    echo "   • Fuzzy finding (Telescope, FZF)"
    echo "   • File tree (NERDTree)"
    echo "   • Syntax highlighting (Treesitter, Polyglot)"
    echo "   • Auto-completion (CoC)"
    echo "   • Git integration (Fugitive)"
    echo "   • Themes (Catppuccin)"
    echo "   • And many more plugins!"
}

# Run main function
main "$@"