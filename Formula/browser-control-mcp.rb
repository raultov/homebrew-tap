class BrowserControlMcp < Formula
  desc "MCP server to control and debug Chrome and Firefox, with JavaScript breakpoints"
  homepage "https://github.com/raultov/browser-control-mcp"
  version "1.0.0-rc.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/raultov/browser-control-mcp/releases/download/v1.0.0-rc.4/browser-control-mcp-aarch64-apple-darwin.tar.xz"
      sha256 "9e1247aa243851ef11d3b6485cf902bb05f54b3aec8949c8509da5ed8444d19e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/raultov/browser-control-mcp/releases/download/v1.0.0-rc.4/browser-control-mcp-x86_64-apple-darwin.tar.xz"
      sha256 "e8b3484bc8f275a766fcae432a7c539924bb1badee6dbaf38577965d3a1f98c4"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/raultov/browser-control-mcp/releases/download/v1.0.0-rc.4/browser-control-mcp-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "98db81d569c67edabbbb63ad407fc927104339dadbc5a3a9f648149a34912e75"
    end
    if Hardware::CPU.intel?
      url "https://github.com/raultov/browser-control-mcp/releases/download/v1.0.0-rc.4/browser-control-mcp-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "3dfef3c048e306348cd75014f06fd457eaf70c9d9f9497fc0c707cb77307dedb"
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
