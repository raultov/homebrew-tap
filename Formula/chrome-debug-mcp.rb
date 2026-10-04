class ChromeDebugMcp < Formula
  desc "Rust MCP Server for full Chrome CDP control and interactive JS debugging"
  homepage "https://github.com/raultov/chrome-debug-mcp"
  version "1.5.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/raultov/chrome-debug-mcp/releases/download/v1.5.5/chrome-debug-mcp-aarch64-apple-darwin.tar.xz"
      sha256 "910548d49b3944c4e43edb35889ab6b2a52bea58058e853d1ad1e3da3cdb49d2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/raultov/chrome-debug-mcp/releases/download/v1.5.5/chrome-debug-mcp-x86_64-apple-darwin.tar.xz"
      sha256 "fab9d57d3d5c8ab5143e6587f5fc6c744007eee80b94d3d2d2aa3a05baf59d2f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/raultov/chrome-debug-mcp/releases/download/v1.5.5/chrome-debug-mcp-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "dba894c0c0d19463c9069d5accd182c2ee5d17a3efb256dcdd0fc189a60828ed"
    end
    if Hardware::CPU.intel?
      url "https://github.com/raultov/chrome-debug-mcp/releases/download/v1.5.5/chrome-debug-mcp-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e54cc406c107916eea88cb158a05473db0642e4ce34a72e73c998be5dac0272f"
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
