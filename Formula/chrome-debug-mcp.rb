class ChromeDebugMcp < Formula
  desc "Rust MCP Server for full Chrome CDP control and interactive JS debugging"
  homepage "https://github.com/raultov/chrome-debug-mcp"
  version "1.5.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/raultov/chrome-debug-mcp/releases/download/v1.5.0/chrome-debug-mcp-aarch64-apple-darwin.tar.xz"
      sha256 "3bfbcedf6e9de427b2da0a037d66bb2732e3d2ce837b6c62c714a85134881839"
    end
    if Hardware::CPU.intel?
      url "https://github.com/raultov/chrome-debug-mcp/releases/download/v1.5.0/chrome-debug-mcp-x86_64-apple-darwin.tar.xz"
      sha256 "5239d31d625dc9d26d3cf2e045a776db79b4722ed4d38f4e20c4feb6e2e28227"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/raultov/chrome-debug-mcp/releases/download/v1.5.0/chrome-debug-mcp-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "479c96c20f0600f98575a3c286b69793e58ecccf12e587b25e125c80ec100416"
    end
    if Hardware::CPU.intel?
      url "https://github.com/raultov/chrome-debug-mcp/releases/download/v1.5.0/chrome-debug-mcp-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "13b7491ae9528789962edd58faa2a8722e28681708666704b4beb726fb2cf3cd"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin": {},
    "x86_64-pc-windows-gnu": {},
    "x86_64-unknown-linux-gnu": {}
  }

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
