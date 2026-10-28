class BrowserControlMcp < Formula
  desc "MCP server to control and debug Chrome and Firefox at runtime: breakpoints, call frames and stepping over CDP and WebDriver BiDi/RDP, plus navigation, DOM, input, screenshots, console and network capture."
  homepage "https://github.com/raultov/browser-control-mcp"
  version "0.3.5-beta.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/raultov/browser-control-mcp/releases/download/v0.3.5-beta.5/browser-control-mcp-aarch64-apple-darwin.tar.xz"
      sha256 "1722de00d36255e32b03233ee53e991d79f785bd383b3fc4c44a75d967029cc3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/raultov/browser-control-mcp/releases/download/v0.3.5-beta.5/browser-control-mcp-x86_64-apple-darwin.tar.xz"
      sha256 "ffca7c3da5ccd60c193bc8637651d16a414b4e3650e5fa82cbb294bf46c30e3c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/raultov/browser-control-mcp/releases/download/v0.3.5-beta.5/browser-control-mcp-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "8962f5db1b008ce21e4898202d4f4e7f25647a5ecf3f109bec99ff73ac4c2b25"
    end
    if Hardware::CPU.intel?
      url "https://github.com/raultov/browser-control-mcp/releases/download/v0.3.5-beta.5/browser-control-mcp-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "2679d3a3925291d4f8072cc726cbf462f4f97bdea1043e4f911fc9c2a7351fdf"
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
