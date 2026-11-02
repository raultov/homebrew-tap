class BrowserControlMcp < Formula
  desc "MCP server to control and debug Chrome and Firefox, with JavaScript breakpoints"
  homepage "https://github.com/raultov/browser-control-mcp"
  version "0.11.0-beta.17"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/raultov/browser-control-mcp/releases/download/v0.11.0-beta.17/browser-control-mcp-aarch64-apple-darwin.tar.xz"
      sha256 "442cecc24ed947c1d16f20defa2c62d2d2675a40df4b05cb47243bc6b21bf432"
    end
    if Hardware::CPU.intel?
      url "https://github.com/raultov/browser-control-mcp/releases/download/v0.11.0-beta.17/browser-control-mcp-x86_64-apple-darwin.tar.xz"
      sha256 "bc444195c7deea71dbaa45ecc2e3f289c57739602d3e523a8e3e4a976857b7b8"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/raultov/browser-control-mcp/releases/download/v0.11.0-beta.17/browser-control-mcp-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "431d24b4d53cae3f1488944966c62cff539116ec0f15809641931847c508b314"
    end
    if Hardware::CPU.intel?
      url "https://github.com/raultov/browser-control-mcp/releases/download/v0.11.0-beta.17/browser-control-mcp-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "af8c48ff290cb9cf0ef57828d1ce485fefa25fe38cd8e1bc9aedc81ac51b20fa"
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
