class MediaTranscriberMcp < Formula
  desc "MCP server for transcribing local video and audio files using Whisper"
  homepage "https://github.com/raultov/media-transcriber-mcp"
  version "0.11.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/raultov/media-transcriber-mcp/releases/download/v0.11.0/media-transcriber-mcp-aarch64-apple-darwin.tar.xz"
      sha256 "b9eceafc921eb68adfbaded88da467b208f7401459682a0535cea298ce6b88ff"
    end
    if Hardware::CPU.intel?
      url "https://github.com/raultov/media-transcriber-mcp/releases/download/v0.11.0/media-transcriber-mcp-x86_64-apple-darwin.tar.xz"
      sha256 "78999a145a2e29733966bf6b43e943a184a5c6c6bdb5d9603b66519f9ba55468"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/raultov/media-transcriber-mcp/releases/download/v0.11.0/media-transcriber-mcp-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "b732a3fbb1a3d7557e5d7245061f071f7c39ec8512919bfc959ad94f810082ba"
    end
    if Hardware::CPU.intel?
      url "https://github.com/raultov/media-transcriber-mcp/releases/download/v0.11.0/media-transcriber-mcp-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "fc2b966b20d5fbe19a505ebeee5a29859f998d8e9316b9300235bdb085e39e47"
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
