# Fórmula generada por deploy/homebrew/render.sh en cada release; no editar en el tap.
class Splitstream < Formula
  desc "Retransmite una señal RTMP de OBS a varias plataformas a la vez"
  homepage "https://github.com/aprendomx/splitstream"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/aprendomx/splitstream/releases/download/v0.13.0/splitstream-v0.13.0-macos-apple-silicon.tar.gz"
      sha256 "184f78d6b68acddb51ce0c84dbfe68096f98ae2d146fe1943bba43c646578586"
    end
    on_intel do
      url "https://github.com/aprendomx/splitstream/releases/download/v0.13.0/splitstream-v0.13.0-macos-intel.tar.gz"
      sha256 "8e0a055c18d811b9ca22651bc3582ff8d344fb589fd2b4b858d352fa1cb5f164"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/aprendomx/splitstream/releases/download/v0.13.0/splitstream-v0.13.0-linux-arm64.tar.gz"
      sha256 "ffd6676b7337f7a4d22623d6e3a74866f892e80fdaf1b3e61e3bfde8cb4823e5"
    end
    on_intel do
      url "https://github.com/aprendomx/splitstream/releases/download/v0.13.0/splitstream-v0.13.0-linux-x86_64.tar.gz"
      sha256 "88c79bc6ce1173315d6aea7cea71c1845e2b1a64f11d5b92afe90a84a1467404"
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
