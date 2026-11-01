class BrowserControlMcp < Formula
  desc "MCP server to control and debug Chrome and Firefox, with JavaScript breakpoints"
  homepage "https://github.com/raultov/browser-control-mcp"
  version "0.9.0-beta.13"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/raultov/browser-control-mcp/releases/download/v0.9.0-beta.13/browser-control-mcp-aarch64-apple-darwin.tar.xz"
      sha256 "912b630b6ff01829d13c9070629146cc35a92f367105817dcb87189e12fb7454"
    end
    if Hardware::CPU.intel?
      url "https://github.com/raultov/browser-control-mcp/releases/download/v0.9.0-beta.13/browser-control-mcp-x86_64-apple-darwin.tar.xz"
      sha256 "b285889819f87c92c112afd61f0a286b588b117c2c23f2a1e1f7897e508f72c4"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/raultov/browser-control-mcp/releases/download/v0.9.0-beta.13/browser-control-mcp-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "650c78ad5ff5745285093843c767612cb3b1f8f91a07875931930680be89feb8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/raultov/browser-control-mcp/releases/download/v0.9.0-beta.13/browser-control-mcp-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d53e6e93131fbad9018b3a33e8002432fc8151bdfb5dfcd02aeac47ddc518786"
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
