# Fórmula generada por deploy/homebrew/render.sh en cada release; no editar en el tap.
class Splitstream < Formula
  desc "Retransmite una señal RTMP de OBS a varias plataformas a la vez"
  homepage "https://github.com/aprendomx/splitstream"
  version "0.10.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/aprendomx/splitstream/releases/download/v0.10.0/splitstream-v0.10.0-macos-apple-silicon.tar.gz"
      sha256 "c9e370a14760441c6264763931c4dffb08d18f01279d40dd38e9d244e0c05e3a"
    end
    on_intel do
      url "https://github.com/aprendomx/splitstream/releases/download/v0.10.0/splitstream-v0.10.0-macos-intel.tar.gz"
      sha256 "92d0a0e2f5ffbdd2075852e76bd072a077e92ef04ae1f27f919c39b9ca0be675"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/aprendomx/splitstream/releases/download/v0.10.0/splitstream-v0.10.0-linux-arm64.tar.gz"
      sha256 "ee985b3afea5880b5b8eaa24e59b1ab98bf78a852cc05707a59f8b51f89a7055"
    end
    on_intel do
      url "https://github.com/aprendomx/splitstream/releases/download/v0.10.0/splitstream-v0.10.0-linux-x86_64.tar.gz"
      sha256 "b9490700273970d9e51005ffba5332f761d20dd52bc1d2946026a97f6f2b1a23"
    end
  end

  def install
    bin.install "splitstream"
    doc.install "manual-de-usuario.md" if File.exist?("manual-de-usuario.md")
  end

  def post_install
    (var/"splitstream").mkpath
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
