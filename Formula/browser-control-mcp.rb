class BrowserControlMcp < Formula
  desc "MCP server to control and debug Chrome and Firefox, with JavaScript breakpoints"
  homepage "https://github.com/raultov/browser-control-mcp"
  version "0.12.0-beta.21"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/raultov/browser-control-mcp/releases/download/v0.12.0-beta.21/browser-control-mcp-aarch64-apple-darwin.tar.xz"
      sha256 "4951630f935ef0aa8dbc52b67262e33d78ee3781c3061acc765f6238de3bdc05"
    end
    if Hardware::CPU.intel?
      url "https://github.com/raultov/browser-control-mcp/releases/download/v0.12.0-beta.21/browser-control-mcp-x86_64-apple-darwin.tar.xz"
      sha256 "c2d19217ccd576c4041f37c186894578dfd2412c3059656324dc3e05c879daf4"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/raultov/browser-control-mcp/releases/download/v0.12.0-beta.21/browser-control-mcp-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "3c0f95a6f301e44000e09f5d7270cab3dbf5b70cfea639d103daac28ef88baa5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/raultov/browser-control-mcp/releases/download/v0.12.0-beta.21/browser-control-mcp-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ff01b4c685902e118af72eb1f4ddaeb6eaf6ada8c9dbba2424c3104f5ecfc39f"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "browser-control-mcp"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "browser-control-mcp"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "browser-control-mcp"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "browser-control-mcp"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
