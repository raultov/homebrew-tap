class BrowserControlMcp < Formula
  desc "MCP server to control and debug Chrome and Firefox at runtime: breakpoints, call frames and stepping over CDP and WebDriver BiDi/RDP, plus navigation, DOM, input, screenshots, console and network capture."
  homepage "https://github.com/raultov/browser-control-mcp"
  version "0.3.4-beta.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/raultov/browser-control-mcp/releases/download/v0.3.4-beta.4/browser-control-mcp-aarch64-apple-darwin.tar.xz"
      sha256 "5034b7122b082d2e8c769f6b6de8e4d1d0343c0e0048c69cbc3e2f7b476ed485"
    end
    if Hardware::CPU.intel?
      url "https://github.com/raultov/browser-control-mcp/releases/download/v0.3.4-beta.4/browser-control-mcp-x86_64-apple-darwin.tar.xz"
      sha256 "0371db4ff87fd128f1e5dfc984879100fa4730293a855c74fa1d9de76113174b"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/raultov/browser-control-mcp/releases/download/v0.3.4-beta.4/browser-control-mcp-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "c234862e595a355a44de1da7940a7f3e55563de998215f7d521034585acbd3a2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/raultov/browser-control-mcp/releases/download/v0.3.4-beta.4/browser-control-mcp-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ed13022f1b0c7e0f10a147bff17f3c1edb0f59e48605494cb05b3885849dc3a4"
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
