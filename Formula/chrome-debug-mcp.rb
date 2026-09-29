class ChromeDebugMcp < Formula
  desc "Rust MCP Server for full Chrome CDP control and interactive JS debugging"
  homepage "https://github.com/raultov/chrome-debug-mcp"
  version "1.5.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/raultov/chrome-debug-mcp/releases/download/v1.5.2/chrome-debug-mcp-aarch64-apple-darwin.tar.xz"
      sha256 "c382c3e1af9c5fa12211f9dc7ad09046c45852912e8cbcad6cf63cc878f9b1a8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/raultov/chrome-debug-mcp/releases/download/v1.5.2/chrome-debug-mcp-x86_64-apple-darwin.tar.xz"
      sha256 "a341857c63edaba756a76a62040a44c95790a0803747cee58561c80083c48fba"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/raultov/chrome-debug-mcp/releases/download/v1.5.2/chrome-debug-mcp-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "b75b66f65d3ae1e47c8b86b792e0b88c96e9d5b0a5d9d273f97e79755e9db826"
    end
    if Hardware::CPU.intel?
      url "https://github.com/raultov/chrome-debug-mcp/releases/download/v1.5.2/chrome-debug-mcp-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ca5714203595d3fc0e3bf29ecd4ee2c21119ad6204decec166d6dbeb12bf1ca0"
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
      bin.install "chrome-debug-mcp"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "chrome-debug-mcp"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "chrome-debug-mcp"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "chrome-debug-mcp"
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
