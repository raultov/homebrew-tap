class BrowserControlMcp < Formula
  desc "MCP server to control and debug Chrome and Firefox, with JavaScript breakpoints"
  homepage "https://github.com/raultov/browser-control-mcp"
  version "0.12.0-beta.22"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/raultov/browser-control-mcp/releases/download/v0.12.0-beta.22/browser-control-mcp-aarch64-apple-darwin.tar.xz"
      sha256 "def6ffbc766acf717fc325ceb24e9f9b30a8b8260f24894f78e3f8bc52ac4782"
    end
    if Hardware::CPU.intel?
      url "https://github.com/raultov/browser-control-mcp/releases/download/v0.12.0-beta.22/browser-control-mcp-x86_64-apple-darwin.tar.xz"
      sha256 "cd9e3b7fef2d160f24b0b3379276e189519344183808ba98adfb9eaea830cbcd"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/raultov/browser-control-mcp/releases/download/v0.12.0-beta.22/browser-control-mcp-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "4264ac693db2c4de5e6c0d87334298e198953aad253e259ab93f487059fdf98e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/raultov/browser-control-mcp/releases/download/v0.12.0-beta.22/browser-control-mcp-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "9a484edc6adae7f66510f474b880221e7da276f60c0e0de68f88746f43f2581d"
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
