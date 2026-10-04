class ChromeDebugMcp < Formula
  desc "Rust MCP Server for full Chrome CDP control and interactive JS debugging"
  homepage "https://github.com/raultov/chrome-debug-mcp"
  version "1.5.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/raultov/chrome-debug-mcp/releases/download/v1.5.4/chrome-debug-mcp-aarch64-apple-darwin.tar.xz"
      sha256 "3e5b7cc19bc99e5d52752d898c15b9849a0ddd295240b0ba11aeac080a995cc9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/raultov/chrome-debug-mcp/releases/download/v1.5.4/chrome-debug-mcp-x86_64-apple-darwin.tar.xz"
      sha256 "d6e44e35f744bad31ed51f5da89340bac5556c33d7a54ceeab543c5283e23b89"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/raultov/chrome-debug-mcp/releases/download/v1.5.4/chrome-debug-mcp-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "ec232fd40a6a22bdfac8a4e4f546efc420ac6d7b0b5ba6c68ea334df768f0840"
    end
    if Hardware::CPU.intel?
      url "https://github.com/raultov/chrome-debug-mcp/releases/download/v1.5.4/chrome-debug-mcp-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ee5e936fdc4fafbf25debb125598ee5830538be5e4041ca2de173ca0d8b19535"
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
