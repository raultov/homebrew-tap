class MediaTranscriberMcp < Formula
  desc "MCP server for transcribing local video and audio files using Whisper"
  homepage "https://github.com/raultov/media-transcriber-mcp"
  version "0.9.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/raultov/media-transcriber-mcp/releases/download/v0.9.1/media-transcriber-mcp-aarch64-apple-darwin.tar.xz"
      sha256 "c75eafcd47dd5feb618a6ec3c8a2decaccaf096372dd952df0739d6961326f96"
    end
    if Hardware::CPU.intel?
      url "https://github.com/raultov/media-transcriber-mcp/releases/download/v0.9.1/media-transcriber-mcp-x86_64-apple-darwin.tar.xz"
      sha256 "2a7e537712f7da536899a111ed35ac18830a7ffaca8447c6e23be10bda1ebd91"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/raultov/media-transcriber-mcp/releases/download/v0.9.1/media-transcriber-mcp-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "487e2271573bdbbcff6400e1b192b44c557c061e1cbda7d7e713ffdba1042e0c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/raultov/media-transcriber-mcp/releases/download/v0.9.1/media-transcriber-mcp-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "14f5cd1e6c1f54addbc0662bd2c8708f482b18505f853cc07f5802338dce42aa"
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
