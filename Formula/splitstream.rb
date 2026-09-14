# Fórmula generada por deploy/homebrew/render.sh en cada release; no editar en el tap.
class Splitstream < Formula
  desc "Retransmite una señal RTMP de OBS a varias plataformas a la vez"
  homepage "https://github.com/aprendomx/splitstream"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/aprendomx/splitstream/releases/download/v1.0.0/splitstream-v1.0.0-macos-apple-silicon.tar.gz"
      sha256 "3442e3903b2801e1c643264dbdf2d9642120a2aa46abca21d1bed9c72149131e"
    end
    on_intel do
      url "https://github.com/aprendomx/splitstream/releases/download/v1.0.0/splitstream-v1.0.0-macos-intel.tar.gz"
      sha256 "da353f831fcdeec39af07d2456418ad0f96df7714ee40f7c8c2b5379c2fc20d4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/aprendomx/splitstream/releases/download/v1.0.0/splitstream-v1.0.0-linux-arm64.tar.gz"
      sha256 "b32c1e782474fb6bba894a303176473dd80e324abef791ee5798f797623b74f1"
    end
    on_intel do
      url "https://github.com/aprendomx/splitstream/releases/download/v1.0.0/splitstream-v1.0.0-linux-x86_64.tar.gz"
      sha256 "eeb11f7005090455dc147f760beeef12c698a06ba51ba4204899696b9561c741"
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
