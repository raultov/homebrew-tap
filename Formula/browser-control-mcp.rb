class BrowserControlMcp < Formula
  desc "MCP server to control and debug Chrome and Firefox at runtime: breakpoints, call frames and stepping over CDP and WebDriver BiDi/RDP, plus navigation, DOM, input, screenshots, console and network capture."
  homepage "https://github.com/raultov/browser-control-mcp"
  version "0.3.2-beta.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/raultov/browser-control-mcp/releases/download/v0.3.2-beta.3/browser-control-mcp-aarch64-apple-darwin.tar.xz"
      sha256 "a86b93e7d1fc89222eec18e4ba958f9fa9ec216a279fdcbff6b168c62aaecd8e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/raultov/browser-control-mcp/releases/download/v0.3.2-beta.3/browser-control-mcp-x86_64-apple-darwin.tar.xz"
      sha256 "6d562ed2bdcdb1e014044ada824eadad195663039a8d9e58f52f45e766d3993f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/raultov/browser-control-mcp/releases/download/v0.3.2-beta.3/browser-control-mcp-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "cded773f3b341a39602a4a016a951b015bfe285b6ff06d545bd4693dab2007e4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/raultov/browser-control-mcp/releases/download/v0.3.2-beta.3/browser-control-mcp-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "8740321d67edcfc5c2f15c7367ab9a89ec4dbdfb53189b7981db8319a41388a8"
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
