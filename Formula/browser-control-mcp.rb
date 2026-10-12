class BrowserControlMcp < Formula
  desc "MCP server to control and debug Chrome and Firefox at runtime: breakpoints, call frames and stepping over CDP and WebDriver BiDi/RDP, plus navigation, DOM, input, screenshots, console and network capture."
  homepage "https://github.com/raultov/browser-control-mcp"
  version "0.1.1-beta.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/raultov/browser-control-mcp/releases/download/v0.1.1-beta.1/browser-control-mcp-aarch64-apple-darwin.tar.xz"
      sha256 "5f4ba788da8733c558b7cdc2f464bb05e05b25381c73ba4cb8b801b3bb876390"
    end
    if Hardware::CPU.intel?
      url "https://github.com/raultov/browser-control-mcp/releases/download/v0.1.1-beta.1/browser-control-mcp-x86_64-apple-darwin.tar.xz"
      sha256 "b36627b8ae410fd4e6bd41c9eb525924ff842c82982b719e9da181ad8c5167ce"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/raultov/browser-control-mcp/releases/download/v0.1.1-beta.1/browser-control-mcp-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "93395737a9434c435399358db58dc70cd672854111ad4c8e98b7f075bb46c08e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/raultov/browser-control-mcp/releases/download/v0.1.1-beta.1/browser-control-mcp-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b4d40d1ef7deab7f52fda9de257b5fb9f3b1aa0528859b09986d07551e188846"
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
