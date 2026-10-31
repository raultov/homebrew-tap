class BrowserControlMcp < Formula
  desc "MCP server to control and debug Chrome and Firefox at runtime: breakpoints, call frames and stepping over CDP and WebDriver BiDi/RDP, plus navigation, DOM, input, screenshots, console and network capture."
  homepage "https://github.com/raultov/browser-control-mcp"
  version "0.4.0-beta.7"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/raultov/browser-control-mcp/releases/download/v0.4.0-beta.7/browser-control-mcp-aarch64-apple-darwin.tar.xz"
      sha256 "5c6cafb616efdfd0a738adce5d0ae4a2aa5441a8153f884f519188b3782f81f8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/raultov/browser-control-mcp/releases/download/v0.4.0-beta.7/browser-control-mcp-x86_64-apple-darwin.tar.xz"
      sha256 "6f7e166dc9515a8c60bbe2eb27844357671422d9c98bc0cb6a8c60c065b4bde6"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/raultov/browser-control-mcp/releases/download/v0.4.0-beta.7/browser-control-mcp-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "46ff5c8739153fa3dd8c20ee4195831dea527fea85bc7fc076ed903fcf8f0915"
    end
    if Hardware::CPU.intel?
      url "https://github.com/raultov/browser-control-mcp/releases/download/v0.4.0-beta.7/browser-control-mcp-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f375eacf2496259b8bf6f4a95e20d033454e34865eaf43c1673c29538e8817db"
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
