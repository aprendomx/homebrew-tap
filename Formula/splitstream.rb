# Fórmula generada por deploy/homebrew/render.sh en cada release; no editar en el tap.
class Splitstream < Formula
  desc "Retransmite una señal RTMP de OBS a varias plataformas a la vez"
  homepage "https://github.com/aprendomx/splitstream"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/aprendomx/splitstream/releases/download/v0.12.0/splitstream-v0.12.0-macos-apple-silicon.tar.gz"
      sha256 "3308028bc9f63bc879d50debef8ed7bbfb333c05a15348a211e2cc50ce541b43"
    end
    on_intel do
      url "https://github.com/aprendomx/splitstream/releases/download/v0.12.0/splitstream-v0.12.0-macos-intel.tar.gz"
      sha256 "633c3dd3bfd0abd54052d62710f06e1e4d6bd1810c073c98bf545fc2d90c61fb"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/aprendomx/splitstream/releases/download/v0.12.0/splitstream-v0.12.0-linux-arm64.tar.gz"
      sha256 "c40e9f464df80a209791b31833177e10e80668ea9de86f515acc55d9e35b408f"
    end
    on_intel do
      url "https://github.com/aprendomx/splitstream/releases/download/v0.12.0/splitstream-v0.12.0-linux-x86_64.tar.gz"
      sha256 "66e584c5d2a8ce611cc3f4077b188d79c4d5c76274597ef3d1f7528c3f3e7227"
    end
  end

  def install
    bin.install "splitstream"
    doc.install "manual-de-usuario.md" if File.exist?("manual-de-usuario.md")
  end

  # `brew services start splitstream`: la base y la clave en var/splitstream, el log en var/log.
  service do
    run [opt_bin/"splitstream"]
    keep_alive true
    working_dir var/"splitstream"
    environment_variables SPLITSTREAM_DB_PATH: var/"splitstream/splitstream.db"
    log_path var/"log/splitstream.log"
    error_log_path var/"log/splitstream.log"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/splitstream -version")
  end
end
