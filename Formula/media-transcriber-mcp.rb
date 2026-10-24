class MediaTranscriberMcp < Formula
  desc "MCP server for transcribing local video and audio files using Whisper"
  homepage "https://github.com/raultov/media-transcriber-mcp"
  version "0.9.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/raultov/media-transcriber-mcp/releases/download/v0.9.0/media-transcriber-mcp-aarch64-apple-darwin.tar.xz"
      sha256 "bd5ec46b4e32a6596c36ec628ad181c9ed997fd8cee534c7d8f06770d0cb80b1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/raultov/media-transcriber-mcp/releases/download/v0.9.0/media-transcriber-mcp-x86_64-apple-darwin.tar.xz"
      sha256 "ad6a8977a4e745d404d3299bd24d227ceb0dfdfa7db88a7d49961278a6a915a4"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/raultov/media-transcriber-mcp/releases/download/v0.9.0/media-transcriber-mcp-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "b58de74895ae397d4f8b71713a9ab7bfd1c14d19a45c16714ccbadc8be843b95"
    end
    if Hardware::CPU.intel?
      url "https://github.com/raultov/media-transcriber-mcp/releases/download/v0.9.0/media-transcriber-mcp-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ee7f99d948016faa3c6fe9f0e5ffe14b8ff247d3c14cdfe05d171ecb54d3957e"
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
      bin.install "media-transcriber-mcp"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "media-transcriber-mcp"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "media-transcriber-mcp"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "media-transcriber-mcp"
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
