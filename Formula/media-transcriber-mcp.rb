class MediaTranscriberMcp < Formula
  desc "MCP server for transcribing local video and audio files using Whisper"
  homepage "https://github.com/raultov/media-transcriber-mcp"
  version "0.10.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/raultov/media-transcriber-mcp/releases/download/v0.10.1/media-transcriber-mcp-aarch64-apple-darwin.tar.xz"
      sha256 "94b7cf1adfd92e88d102202dfb0f7f7840466e12a77731e15603445a8cb88cf1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/raultov/media-transcriber-mcp/releases/download/v0.10.1/media-transcriber-mcp-x86_64-apple-darwin.tar.xz"
      sha256 "8ac11014a20246f0b626cdd6e53b11195092e5baa5280cd5c583e0ddd7984645"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/raultov/media-transcriber-mcp/releases/download/v0.10.1/media-transcriber-mcp-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "03dbc85df6c932cf8a85a194d3094381cfa3b8785262f8efda9ba604e3b2d39e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/raultov/media-transcriber-mcp/releases/download/v0.10.1/media-transcriber-mcp-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "aed16da5a4e59837ea48f3f392f69dcf2641b3597e5c1bee847d5ae2f218f187"
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
