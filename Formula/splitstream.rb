# Fórmula generada por deploy/homebrew/render.sh en cada release; no editar en el tap.
class Splitstream < Formula
  desc "Retransmite una señal RTMP de OBS a varias plataformas a la vez"
  homepage "https://github.com/aprendomx/splitstream"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/aprendomx/splitstream/releases/download/v0.11.0/splitstream-v0.11.0-macos-apple-silicon.tar.gz"
      sha256 "6650705f52d1b708428a0ff8c04807cc8bf48a7bce24d7ee8fde32eeaf402445"
    end
    on_intel do
      url "https://github.com/aprendomx/splitstream/releases/download/v0.11.0/splitstream-v0.11.0-macos-intel.tar.gz"
      sha256 "0ba9bec61621d7b04f30d1de448aed7bde0a73d157b7fb204fbfd60d25a648a1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/aprendomx/splitstream/releases/download/v0.11.0/splitstream-v0.11.0-linux-arm64.tar.gz"
      sha256 "b45422d795500a989c734ab7b0b2b483e02d33d06e0a2049d8c0d3d7a7a340a1"
    end
    on_intel do
      url "https://github.com/aprendomx/splitstream/releases/download/v0.11.0/splitstream-v0.11.0-linux-x86_64.tar.gz"
      sha256 "2efd38ff9805258e53de830047927394e4e1f6821a567b08b9191bdcf4b3cefa"
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
