class MediaTranscriberMcp < Formula
  desc "MCP server for transcribing local video and audio files using Whisper"
  homepage "https://github.com/raultov/media-transcriber-mcp"
  version "0.8.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/raultov/media-transcriber-mcp/releases/download/v0.8.0/media-transcriber-mcp-aarch64-apple-darwin.tar.xz"
      sha256 "6f3a3225839899a9aa2c062706020312ece9c210b186a657382e147ef11adadb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/raultov/media-transcriber-mcp/releases/download/v0.8.0/media-transcriber-mcp-x86_64-apple-darwin.tar.xz"
      sha256 "58f3c2f3d44433084b39c64cf0014a57d65797c2e445b11098030c9a73e97792"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/raultov/media-transcriber-mcp/releases/download/v0.8.0/media-transcriber-mcp-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "53a269674daccf7761260e81d1356e1e160f2bcd4995ca2bfcf1e1c3b9d83831"
    end
    if Hardware::CPU.intel?
      url "https://github.com/raultov/media-transcriber-mcp/releases/download/v0.8.0/media-transcriber-mcp-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "1d28e2eba9ccb18ea257c8e65538b64db2a9282e683ad30ce475a01828d13b9c"
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
