class ChromeDebugMcp < Formula
  desc "Rust MCP Server for full Chrome CDP control and interactive JS debugging"
  homepage "https://github.com/raultov/chrome-debug-mcp"
  version "1.5.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/raultov/chrome-debug-mcp/releases/download/v1.5.1/chrome-debug-mcp-aarch64-apple-darwin.tar.xz"
      sha256 "6d712b91ee3ca3721d8d4993bc59920de197ca853079ca01b718885bb4a90d90"
    end
    if Hardware::CPU.intel?
      url "https://github.com/raultov/chrome-debug-mcp/releases/download/v1.5.1/chrome-debug-mcp-x86_64-apple-darwin.tar.xz"
      sha256 "9ff7dd00e404064fdcefabaac51e931c22b07539acd626b330dc08d28c1bf9e1"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/raultov/chrome-debug-mcp/releases/download/v1.5.1/chrome-debug-mcp-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "a421af3d519163d7cb066015cc63864ea2c69757d8db111e660a9b237797c7e5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/raultov/chrome-debug-mcp/releases/download/v1.5.1/chrome-debug-mcp-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "62a81f6f0500fe3cf365a91d1de6b674f149fa7c7b8735f350097aa5c159c9a8"
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
